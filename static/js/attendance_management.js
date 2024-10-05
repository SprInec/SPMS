function addAttendanceRecord() {
    // 提示用户输入员工ID
    const employeeId = prompt('请输入员工ID:');
    if (!employeeId) return; // 如果用户取消输入，直接返回

    // 获取开始时间和结束时间的值
    const startTime = document.getElementById('startTimeInput').value;
    const endTime = document.getElementById('endTimeInput').value;

    // 构建要发送的数据对象
    const data = {
        employeeId: employeeId,
        startTime: startTime,
        endTime: endTime
    };

    // 发送数据到后端
    fetch('/attendances', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => {
        if (response.ok) {
            return response.json();
        } else {
            throw new Error('添加考勤记录失败!');
        }
    })
    .then(result => {
            alert(result.message);
            loadAttendanceRecords(); // 重新加载考勤记录
    })
    .catch(error => {
        console.error('Error:', error);
        alert(error.message);
    });
}


// 加载考勤记录并显示在表格中
function loadAttendanceRecords() {
    const tableBody = document.getElementById('attendanceTableBody2');

    // 清空表格内容
    tableBody.innerHTML = '';

    // 发送 GET 请求获取考勤记录
    fetch('/attendances', {
        method: 'GET'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to fetch attendance records');
        }
        return response.json();
    })
    .then(records => {
        // 遍历考勤记录数据并创建表格行
        records.forEach(record => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${record.employee_id}</td>
                <td>${record.employee_name}</td>
                <td>${record.check_in}</td>
                <td>${record.check_out}</td>
                <td>${record.status}</td>
                <td>
                    <button onclick="editAttendance(${record.id})">编辑</button>
                    <button onclick="deleteAttendance(${record.id})">删除</button>
                </td>
            `;
            tableBody.appendChild(row);
        });
    })
    .catch(error => {
        console.error('Error:', error);
        alert('加载考勤记录失败，请重试');
    });
}

// 编辑考勤记录
function editAttendance(attendanceId) {
    const startTime = document.getElementById('startTimeInput').value;
    const endTime = document.getElementById('endTimeInput').value;
    // 获取当前日期并格式化为 YYYY-MM-DD 的格式
    const today = new Date().toISOString().split('T')[0];

    // 让用户仅输入时间（格式：HH:MM）
    const timeIn = prompt('请输入签到时间 (格式: HH:MM 例: 08:00):');
    const timeOut = prompt('请输入签退时间 (格式: HH:MM 例: 17:00):');

    // 将时间附加到今天的日期上
    const checkIn = `${today} ${timeIn}:00`; // 注意秒数已经被设置为00
    const checkOut = `${today} ${timeOut}:00`; // 注意秒数已经被设置为00

    if (!checkIn || !checkOut) {
        alert('请输入有效的时间');
        return;
    }

    // 发送 PUT 请求更新考勤记录
    fetch(`/attendances/${attendanceId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            startTime: startTime,
            endTime: endTime,
            check_in: checkIn,
            check_out: checkOut
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to edit attendance record');
        }
        alert('成功编辑考勤记录');
        loadAttendanceRecords(); // 重新加载考勤记录
    })
    .catch(error => {
        console.error('Error:', error);
        alert('编辑考勤记录失败，请重试');
    });
}

// 删除考勤记录
function deleteAttendance(attendanceId) {
    if (!confirm('确定要删除该考勤记录吗？')) {
        return;
    }

    // 发送 DELETE 请求删除考勤记录
    fetch(`/attendances/${attendanceId}`, {
        method: 'DELETE'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to delete attendance record');
        }
        alert('成功删除考勤记录');
        loadAttendanceRecords(); // 重新加载考勤记录
    })
    .catch(error => {
        console.error('Error:', error);
        alert('删除考勤记录失败，请重试');
    });
}

// 搜索考勤记录
function filterAttendanceRecords() {
    const searchInput = document.getElementById('attendanceSearch');
    const keyword = searchInput.value.trim().toLowerCase(); // 获取输入的搜索关键字

    const tableBody = document.getElementById('attendanceTableBody2');
    const rows = tableBody.getElementsByTagName('tr');

    // 遍历表格行，根据关键字显示匹配的记录
    for (const row of rows) {
        const idCell = row.getElementsByTagName('td')[0]; // 员工ID单元格
        const nameCell = row.getElementsByTagName('td')[1]; // 姓名单元格
        const stateCell = row.getElementsByTagName('td')[4]; // 状态单元格

        // 获取员工ID和姓名，转换为小写字符串
        const idText = idCell.textContent.trim().toLowerCase();
        const nameText = nameCell.textContent.trim().toLowerCase();
        const stateText = stateCell.textContent.trim().toLowerCase();

        // 判断关键字是否与员工ID完全匹配
        if (idText === keyword || nameText.includes(keyword) || stateText.includes(keyword)) {
            row.style.display = ''; // 显示符合条件的行
        } else {
            row.style.display = 'none'; // 隐藏不符合条件的行
        }
    }
}


function generateAttendanceReport() {
    // 获取当天考勤数据并填充表格和图表
    fetch('/get_attendance_data')
        .then(response => response.json())
        .then(data => {
            // 填充表格数据
            const tableBody = document.getElementById('attendanceTableBody1');
            const statusCount = {};
            data.forEach(item => {
                if (statusCount[item.status]) {
                    statusCount[item.status]++;
                } else {
                    statusCount[item.status] = 1;
                }
            });
            tableBody.innerHTML = '';
            Object.entries(statusCount).forEach(([status, count]) => {
                const row = `<tr><td>${status}</td><td>${count}</td></tr>`;
                tableBody.innerHTML += row;
            });

            // 生成图表
            const ctx = document.getElementById('attendanceChart').getContext('2d');
            const chart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: Object.keys(statusCount),
                    datasets: [{
                        label: '考勤统计',
                        data: Object.values(statusCount),
                        backgroundColor: [
                            'rgba(5, 94, 189, 0.2)', // 深蓝色，透明度调整为0.2
                            'rgba(5, 94, 189, 0.3)', // 同色，透明度增加
                            'rgba(5, 94, 189, 0.4)', // 同色，透明度再增加
                            'rgba(5, 94, 189, 0.5)', // 同色，透明度再增加
                            'rgba(5, 94, 189, 0.6)', // 同色，透明度再增加
                        ],
                        borderColor: [
                            'rgba(5, 94, 189, 1)', // 原始深蓝色，不透明
                            'rgba(4, 84, 170, 1)', // 略微调亮
                            'rgba(3, 74, 151, 1)', // 继续调亮
                            'rgba(2, 64, 132, 1)', // 继续调亮
                            'rgba(1, 54, 113, 1)', // 继续调亮
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    plugins: {
                        legend: {
                            display: false // 这会隐藏图例
                        }
                    }
                }
            });

            // 显示考勤报表区域
            const attendanceReportDiv = document.querySelector('.attendance-report');
            attendanceReportDiv.style.display = 'block';
        })
        .catch(error => {
            console.error('Failed to fetch attendance data:', error);
        });
}

// 页面加载完成时自动加载考勤记录
document.addEventListener('DOMContentLoaded', () => {
    loadAttendanceRecords();
});

