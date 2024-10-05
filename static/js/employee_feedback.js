// 加载考勤记录并显示在表格中
function loadFeedbackTable() {
    const tableBody = document.getElementById('FeedbackTableBody');

    // 清空表格内容
    tableBody.innerHTML = '';

    // 发送 GET 请求获取考勤记录
    fetch('/feedbacks', {
        method: 'GET'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to fetch feedback records');
        }
        return response.json();
    })
    .then(records => {
        records.forEach(record => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${record.name}</td>
                <td>${record.feedback_type}</td>
                <td>${record.comments}</td>
                <td>${record.date}</td>
            `;
            tableBody.appendChild(row);
        });
    })
    .catch(error => {
        console.error('Error:', error);
        alert('加载失败员工反馈信息失败，请重试');
    });
}

function submitFeedback() {
    const name = document.getElementById('emp_name').value;
    const feedback_type = document.getElementById('feedback_type').value;
    const feedback_comments = document.getElementById('feedback_comments').value;

    // 构建要发送的数据对象i
    const data = {
        name: name,
        feedback_type: feedback_type,
        comments: feedback_comments,
    };

    // 发送数据到后端
    fetch('/feedbacks', {
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
            throw new Error('添加失败!');
        }
    })
    .then(result => {
            alert(result.message);
            loadFeedbackTable(); 
    })
    .catch(error => {
        console.error('Error:', error);
        alert(error.message);
    });
}

loadFeedbackTable();