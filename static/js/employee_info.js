function addEmployee() {
    const name = document.getElementById('name').value;
    const sex = document.getElementById('sex').value;
    const title = document.getElementById('title').value;
    const faculties = document.getElementById('faculties').value;
    const phone = document.getElementById('phone').value;

    fetch('/employees', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ name, sex, title, faculties, phone}),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to add employee');
        }
        return response.json();
    })
    .then(result => {
        alert(result.message);
        document.getElementById('employeeForm').reset();
        loadEmployees(); // 添加员工成功后重新加载员工列表
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Failed to add employee. Please try again.');
    });
}


function editEmployee(employeeId) {
    const newName = prompt('Enter new name:', '');
    const newSex = prompt('Enter new Sex:', '');
    const newTitle = prompt('Enter new title:', '');
    const newFaculty = prompt('Enter new faculty:', '');
    const newPhone = prompt('Enter new phone:', '');

    fetch(`/employees/${employeeId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            name: newName,
            sex: newSex,
            title: newTitle,
            phone: newPhone,
            faculties: newFaculty,
        }),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to edit employee');
        }
        return response.json();
    })
    .then(result => {
        alert(result.message);
        loadEmployees(); // 编辑员工成功后重新加载员工列表
    })
    .catch(error => {
        console.error('Error:', error);
        alert(error.message);
    });
}


function deleteEmployee(employeeId) {
        const confirmDelete = confirm('Are you sure you want to delete this employee?');

    if (!confirmDelete) {
        return;
    }

    fetch(`/employees/${employeeId}`, {
        method: 'DELETE',
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to delete employee');
        }
        alert('删除成功!');
        loadEmployees();
        loadAttendanceRecords();
        loadSalaries();
        getEmployeeWelfareInfo();
        loadEvaluationTable();
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Failed to delete employee. Please try again.');
    });
}

function uploadPhoto(employeeId) {
    const fileInput = document.createElement('input');
    fileInput.type = 'file';
    fileInput.accept = 'image/*'; // 限制只能选择图片文件
    fileInput.onchange = function(e) {
        const file = e.target.files[0];
        if (file) {
            // 创建FormData并添加文件
            const formData = new FormData();
            formData.append('photo', file);

            // 发送POST请求到后端，上传文件
            fetch(`/employees/${employeeId}/upload-photo`, {
                method: 'POST',
                body: formData,
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Failed to upload photo');
                }
                return response.json();
            })
            .then(result => {
                alert(result.message);
                loadEmployees();
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Failed to upload photo. Please try again.');
            });
        }
    };
    fileInput.click(); // 触发文件选择对话框
}

// 加载员工列表
function loadEmployees() {
    fetch('/employees')
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to load employees');
        }
        return response.json();
    })
    .then(employees => {
        const tableBody = document.getElementById('employeeTableBody');
        tableBody.innerHTML = '';

        employees.forEach(employee => {
            const row = tableBody.insertRow();
            row.insertCell(0).textContent = employee.id;
            row.insertCell(1).textContent = employee.name;
            row.insertCell(2).textContent = employee.sex;
            row.insertCell(3).textContent = employee.title;
            row.insertCell(4).textContent = employee.faculties;
            row.insertCell(5).textContent = employee.phone;

            const photoCell = row.insertCell(6);

            // 检查是否存在照片 URL
            if (employee.photoUrl) {
                // 创建显示图片的 img 元素
                const img = document.createElement('img');
                img.src = employee.photoUrl;
                img.style.maxHeight = '100px'; // 控制显示图片的最大高度
                img.style.cursor = 'pointer';

                // 右击删除图片或重新上传图片
                img.oncontextmenu = function(e) { 
                    e.preventDefault(); // 阻止默认右键菜单

                    const deleteConfirm = confirm('Are you sure you want to delete this photo?');

                    if (deleteConfirm) {
                        fetch(`/employees/${employee.id}/delete-photo`, {
                            method: 'DELETE',
                        })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Failed to delete photo');
                            }
                            return response.json();
                        })
                        .then(result => {
                            alert(result.message);
                            loadEmployees(); // 删除图片成功后重新加载员工列表
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Failed to delete photo. Please try again.');
                        });
                    } else {
                        uploadPhoto(employee.id); // 重新上传图片
                    }
                };

                // 点击图片查看大图
                img.onclick = function() { 
                    console.log('Clicked on image with URL:', employee.photoUrl); // 输出点击的图片URL到控制台
                    viewPhoto(employee.photoUrl); 
                };

                // 将图片添加到单元格中
                photoCell.appendChild(img);
            } else {
                // 图片不存在时，创建上传照片的图标
                const uploadIcon = document.createElement('i');
                uploadIcon.className = 'fas fa-upload'; // 使用Font Awesome图标
                uploadIcon.style.cursor = 'pointer';
                uploadIcon.title = 'Upload Photo';

                // 点击图标上传照片
                uploadIcon.onclick = function() { 
                    uploadPhoto(employee.id); // 调用上传图片函数
                };

                // 将图标添加到单元格中
                photoCell.appendChild(uploadIcon);
            }


            // 添加编辑和删除按钮
            const actionsCell = row.insertCell(7);
            const buttonContainer = document.createElement('div');
            buttonContainer.className = 'button-container';

            const editButton = document.createElement('button');
            editButton.textContent = 'Edit';
            editButton.addEventListener('click', () => editEmployee(employee.id));
            buttonContainer.appendChild(editButton);

            const deleteButton = document.createElement('button');
            deleteButton.textContent = 'Delete';
            deleteButton.addEventListener('click', () => deleteEmployee(employee.id));
            buttonContainer.appendChild(deleteButton);

            actionsCell.appendChild(buttonContainer);

        });
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Failed to load employees. Please try again.');
    });
}

function viewPhoto(photoUrl) {
    // 使用 window.open() 方法打开新窗口或标签页显示图片链接
    window.open(photoUrl, '_blank');
}

function filterEmployees() {
    //获取输入元素和过滤条件
    const searchInput = document.getElementById('search');
    const filter = searchInput.value.trim().toUpperCase();

    // 获取包含员工列表的表格体
    const tableBody = document.getElementById('employeeTableBody');
    const rows = tableBody.getElementsByTagName('tr'); 

    // 遍历所有表格行，根据搜索条件显示/隐藏行
    for (let i = 0; i < rows.length; i++) {
        const idColumn = rows[i].getElementsByTagName('td')[0]; // 员工ID所在列的索引
        const nameColumn = rows[i].getElementsByTagName('td')[1]; // 员工姓名所在列的索引
        const sexColumn = rows[i].getElementsByTagName('td')[2]; // 员工性别所在列的索引
        const positionColumn = rows[i].getElementsByTagName('td')[3]; // 员工职位所在列的索引
        const facultyColumn = rows[i].getElementsByTagName('td')[4]; // 员工学院所在列的索引

        if (nameColumn && positionColumn && idColumn && sexColumn && facultyColumn) {
            const idValue = idColumn.textContent || idColumn.innerText;
            const nameValue = nameColumn.textContent || nameColumn.innerText;
            const positionValue = positionColumn.textContent || positionColumn.innerText;
            const facultyValue = facultyColumn.textContent || facultyColumn.innerText;
            const sexValue = sexColumn.textContent || sexColumn.innerText;

            // 根据是否匹配搜索条件来显示/隐藏行
            if (
                nameValue.toUpperCase().includes(filter) ||
                facultyValue.toUpperCase().includes(filter) ||
                positionValue.toUpperCase().includes(filter) ||
                sexValue.toUpperCase().includes(filter) ||
                idValue.trim() === filter.trim() // 使用严格相等比较员工ID
            ) {
                rows[i].style.display = '';
            } else {
                rows[i].style.display = 'none';
            }
        }
    }
}


loadEmployees();