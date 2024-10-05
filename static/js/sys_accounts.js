// 加载考勤记录并显示在表格中
function loadAccountTable() {
    const tableBody = document.getElementById('SysAccountsTableBody');

    // 清空表格内容
    tableBody.innerHTML = '';

    // 发送 GET 请求获取考勤记录
    fetch('/accounts', {
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
                <td>${record.id}</td>
                <td>${record.userid}</td>
                <td>${record.username}</td>
                <td>${record.account}</td>
                <td>${record.rights}</td>
                <td>
                    <button onclick="editAccountPassword(${record.id})">修改密码</button>
                    <button onclick="editAccountRights(${record.id})">编辑权限</button>
                    <button onclick="deleteAccount(${record.id})">注销</button>
                </td>
            `;
            tableBody.appendChild(row);
        });
    })
    .catch(error => {
        console.error('Error:', error);
        alert('加载失败，请重试');
    });
}

function addAccount() {
    const account = prompt('请输入账号:');
    const password = prompt('请输入密码:');
    const rights = 'normal';

    if (!account || !password || !rights) {
        alert('请填写所有必填项');
        return;
    }

    // 构建要发送的数据对象i
    const data = {
        account: account,
        password: password,
        rights: rights,
    };

    // 发送数据到后端
    fetch('/accounts', {
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
            throw new Error('添加账号失败!');
        }
    })
    .then(result => {
            alert(result.message);
            loadAccountTable(); // 重新加载账户列表
    })
    .catch(error => {
        console.error('Error:', error);
        alert(error.message);
    });
}

// 修改账户密码
function editAccountPassword(accountId) {
    const password = prompt('请输入新的密码:');

    if (!password) {
        alert('请输入有效的密码');
        return;
    }

    fetch(`/accounts/${accountId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            password: password,
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to edit account password');
        }
        alert('成功修改账户密码');
        loadAccountTable(); 
    })
    .catch(error => {
        console.error('Error:', error);
        alert('修改密码失败，请重试');
    });
}

// 修改账户权限
function editAccountRights(accountId) {
    const right = prompt('请输入权限(normal/admin):');

    if (right !== 'normal' && right !== 'admin') {
        alert('请输入有效的权限');
        return;
    }

    fetch(`/accounts/edit_rights/${accountId}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            rights: right,
        })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed');
        }
        alert('成功修改账户权限');
        loadAccountTable(); 
    })
    .catch(error => {
        console.error('Error:', error);
        alert('修改权限失败，请重试');
    });
}

// 注销账户
function deleteAccount(accountId) {
    if (!confirm('确定要注销该账户吗？')) {
        return;
    }

    // 发送 DELETE 请求删除考勤记录
    fetch(`/accounts/${accountId}`, {
        method: 'DELETE'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to delete account');
        }
        alert('成功注销');
        loadAccountTable(); // 重新加载考勤记录
    })
    .catch(error => {
        console.error('Error:', error);
        alert('账号注销失败，请重试');
    });
}

function filterSysAccounts() {
    //获取输入元素和过滤条件
    const searchInput = document.getElementById('search_sys_accounts');
    const filter = searchInput.value.trim().toUpperCase();

    // 获取包含员工列表的表格体
    const tableBody = document.getElementById('SysAccountsTableBody');
    const rows = tableBody.getElementsByTagName('tr'); 

    // 遍历所有表格行，根据搜索条件显示/隐藏行
    for (let i = 0; i < rows.length; i++) {
        const idColumn = rows[i].getElementsByTagName('td')[1]; 
        const nameColumn = rows[i].getElementsByTagName('td')[2]; 
        const accountColumn = rows[i].getElementsByTagName('td')[3]; 
        const rightsColumn = rows[i].getElementsByTagName('td')[4]; 

        if (nameColumn && accountColumn && idColumn  && rightsColumn) {
            const idValue = idColumn.textContent || idColumn.innerText;
            const nameValue = nameColumn.textContent || nameColumn.innerText;
            const accountValue = accountColumn.textContent || accountColumn.innerText;
            const rightsValue = rightsColumn.textContent || rightsColumn.innerText;

            // 根据是否匹配搜索条件来显示/隐藏行
            if (
                nameValue.toUpperCase().includes(filter) ||
                rightsValue.toUpperCase().includes(filter) ||
                accountValue.toUpperCase().includes(filter) ||
                idValue.trim() === filter.trim() // 使用严格相等比较员工ID
            ) {
                rows[i].style.display = '';
            } else {
                rows[i].style.display = 'none';
            }
        }
    }
}


loadAccountTable();