//福利管理
//获取tbody
const welfareListContainer=document.getElementById('welfareListContainer')
//获取更新按钮
const updateWelfare=document.getElementById('updateWelfare')
const itemStr=`<tr>
                <td>[id]</td>
                <td>[name]</td>
                <td>[health_insurance]</td>
                <td>[retirement_plans]</td>
                <td>[vacation_policies]</td>
                <td>[sick_leave]</td>
                <td>[holiday_bonuses]</td>
               </tr>`
//封装请求员工数据函数
function getEmployeeWelfareInfo(){
    fetch('/welfare',{
        method:'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    }).then(function(response){
        if(response.ok){
            return response.json()
        }else{
            alert('error')
        }
    }).then(function(res){
        showWelfareList(res.employees)
    })
}
//列表渲染函数
function showWelfareList(arr){
    let tempStr=''
    for(i in arr){
        let str=itemStr;
        str=str.replace('[id]',arr[i].id).replace('[name]',arr[i].name)
            .replace('[health_insurance]',arr[i].health_insurance?'yes':'no')
            .replace('[retirement_plans]',arr[i].retirement_plans?'yes':'no')
            .replace('[vacation_policies]',arr[i].vacation_policies?'yes':'no')
            .replace('[sick_leave]',arr[i].sick_leave).replace('[holiday_bonuses]',arr[i].holiday_bonuses);
        tempStr+=str
    }
    welfareListContainer.innerHTML=tempStr
}
//封装更新请求函数
function reqUpdataWelfare(data){
     fetch(`/welfare/${data.id}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to add employee');
        }
        return response.json();
    }).then(res=>{
        getEmployeeWelfareInfo()
    })
}
//整理添加员工福利
function handleUpdateWelfare(){
    updateWelfare.addEventListener('click',function(e){
        event.preventDefault()
        const empId=document.getElementById('emp_id').value
        const health_insurance=document.getElementById('health_insurance').checked?1:0
        const retirement_plans=document.getElementById('retirement_plans').checked?1:0
        const vacation_policies=document.getElementById('vacation_policies').checked?1:0
        const sick_leave=document.getElementById('sick_leave').value
        const holiday_bonuses=document.getElementById('holiday_bonuses').value

        let data={
            id:empId,
            health_insurance,
            retirement_plans,
            vacation_policies,
            sick_leave,
            holiday_bonuses
        }
        reqUpdataWelfare(data)
        document.getElementById('emp_id').value=''
        document.getElementById('sick_leave').value=''
        document.getElementById('holiday_bonuses').value=''
        document.getElementById('health_insurance').checked=false
        document.getElementById('retirement_plans').checked=false
        document.getElementById('vacation_policies').checked=false
    })
}

function filterEmployees_welfare() {
    //获取输入元素和过滤条件
    const searchInput = document.getElementById('search_welfare');
    const filter = searchInput.value.trim().toUpperCase();

    // 获取包含员工列表的表格体
    const tableBody = document.getElementById('welfareListContainer');
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

getEmployeeWelfareInfo()
handleUpdateWelfare()