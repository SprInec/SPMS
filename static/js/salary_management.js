function loadSalaries() {
    const tableBody = document.getElementById('salaryTableBody');
    tableBody.innerHTML = '';

    fetch('/salaries', {
        method: 'GET',
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to load salaries');
        }
        return response.json();
    })
    .then(salaries => {

        salaries.forEach(salary => {
            const row = tableBody.insertRow();
            row.insertCell(0).textContent = salary.employeeId;
            row.insertCell(1).textContent = salary.name;
            row.insertCell(2).textContent = salary.basicSalary;
            row.insertCell(3).textContent = salary.performanceBonus;

            // 添加编辑和删除按钮
            const actionsCell = row.insertCell(4);
            const buttonContainer = document.createElement('div');
            buttonContainer.className = 'button-container';

            const editButton = document.createElement('button');
            editButton.textContent = 'Edit';
            editButton.addEventListener('click', () => editSalary(salary.employeeId));
            buttonContainer.appendChild(editButton);

            actionsCell.appendChild(buttonContainer);
        });
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Failed to load salaries. Please try again.');
    });
}

function editSalary(employeeId) {
    // 让用户仅输入时间（格式：HH:MM）
    const base = prompt('请输入基本工资:');
    const bonus = prompt('请输入绩效奖金:');

    // 发送 PUT 请求更新考勤记录
    fetch(`/salaries/${employeeId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            base: base,
            bonus: bonus,
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to edit salary');
        }
        alert('成功编辑员工薪资');
        loadSalaries(); // 重新加载考勤记录
    })
    .catch(error => {
        console.error('Error:', error);
        alert('编辑失败，请重试');
    });
}


function filterEmployees_salary() {
    //获取输入元素和过滤条件
    const searchInput = document.getElementById('search_salary');
    const filter = searchInput.value.trim().toUpperCase();

    // 获取包含员工列表的表格体
    const tableBody = document.getElementById('salaryTableBody');
    const rows = tableBody.getElementsByTagName('tr'); 

    // 遍历所有表格行，根据搜索条件显示/隐藏行
    for (let i = 0; i < rows.length; i++) {
        const idColumn = rows[i].getElementsByTagName('td')[0]; 
        const nameColumn = rows[i].getElementsByTagName('td')[1]; 

        if (nameColumn && idColumn) {
            const idValue = idColumn.textContent || idColumn.innerText;
            const nameValue = nameColumn.textContent || nameColumn.innerText;

            // 根据是否匹配搜索条件来显示/隐藏行
            if (
                nameValue.toUpperCase().includes(filter) ||
                idValue.trim() === filter.trim() // 使用严格相等比较员工ID
            ) {
                rows[i].style.display = '';
            } else {
                rows[i].style.display = 'none';
            }
        }
    }
}


document.addEventListener('DOMContentLoaded', () => {
    loadSalaries();
});