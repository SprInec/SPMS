//招聘信息数组
let postJobList=[]
//应聘信息数组
let applyInfoList=[]

//发布招聘按钮
const postJob=document.getElementById('post-job')
//获取职位发布弹窗
const jobPop=document.getElementById('jobPop')
//获取职位
const job=document.getElementById('job')
//获取职位描述
const description=document.getElementById('description')
//获取职位需求
const requirement=document.getElementById('requirement')
//获取职位联系方式
const email=document.getElementById('email')
//获取职位发布按钮
const jobApplySubmit=document.getElementById('job-applySubmit')
//获取职位发布按钮
const jobCancelSubmit=document.getElementById('job-cancelSubmit')


//获取求职弹窗
const pop=document.getElementById('pop')
//获取求职提交按钮
const applySubmit=document.getElementById('applySubmit')
//获取求职取消按钮
const cancelSubmit=document.getElementById('cancelSubmit')
//获取求职姓名的input框
const applicant=document.getElementById('applicant')
//获取求职联系方式的input框
const contactWay=document.getElementById('contactWay')
//个人简介
const introduce=document.getElementById('introduce')
//应聘职位的索引
let jobIndex=0


//请求函数
const reqFunctions={
    //请求应聘者信息
    reqApplicantInfo(){
        fetch('/applicants',{
            method:'GET',
        }).then(res=>{
            if(res.ok){
                return res.json()
            }
        }).then(res=>{
            applyInfoList=res
            showApplyList()
        })
    },
    //请求招聘数据
    reqPostInfo(){
    fetch('/jobs',{
        method:'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    }).then(res=>{
        if(res.ok){
            return res.json()
        }
    }).then(res=>{
        postJobList=res
        showJobList()
    })
},
    //请求添加职位
    reqAddPost(data){
        fetch('/addjob',{
            method:'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        }).then(res=>{
            if(res.ok){
                return res.json()
            }
        }).then(res=>{
            reqFunctions.reqPostInfo()
        })
    },
    //请求添加应聘信息
    reqAddApplicant(data){
        fetch('/addapplicant',{
            method:'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        }).then(res=>{
            if(res.ok){
                return res.json()
            }
        }).then(res=>{
            reqFunctions.reqApplicantInfo()
        })
    }
}


//渲染招聘信息
function showJobList(){
    let trStr=`<tr>
                <td>[job]</td>
                <td id='job-description'>[description]</td>
                <td id='job-requirement'>[requirement]</td>
                <td>[email]</td>
                <td><button id='apply' data-id="[id]">Apply</button></td>
            </tr>`

    //获取tbody
    const tbody=document.getElementById('jobInfo')
    let tbodyContentStr=''
    //遍历数组渲染职位信息
    for(let i in postJobList){
        let temp=trStr
        temp=temp.replace('[job]',postJobList[i].job).replace('[description]',postJobList[i].description)
            .replace('[requirement]',postJobList[i].requirement).replace('[id]',i).replace('[email]',postJobList[i].email)
        tbodyContentStr+=temp
    }
    tbody.innerHTML=tbodyContentStr

}
//渲染应聘信息
function showApplyList() {
    let trStr=`<tr>
                    <td>[applicantName]</td>
                    <td>[position]</td>
                    <td>[contactWay]</td>
                    <td id='apply-intro'>[introduce]</td>
                </tr>`
    //获取tbody
    const tbody=document.getElementById('applyInfo')
    let tbodyContentStr=''
    //遍历数组渲染职位信息
    for(let i in applyInfoList){
        let temp=trStr
        temp=temp.replace('[applicantName]',applyInfoList[i].applicantName)
            .replace('[position]',applyInfoList[i].position)
            .replace('[contactWay]',applyInfoList[i].contactWay).replace('[introduce]',applyInfoList[i].introduce)
        tbodyContentStr+=temp
    }
    tbody.innerHTML=tbodyContentStr
}

//点击事件，出现弹窗
function clickApply(){
const tbody=document.getElementById('jobInfo')
//*******应聘**********
tbody.addEventListener('click',function(e){
    if(e.target.tagName=="BUTTON"){
        //获取点击的index值
       let index= e.target.dataset.id
        // 显示弹窗
        document.getElementById('overlay').style.display = 'block'; // 显示遮罩层
       pop.style.display='block'
        //改变索引的值
       jobIndex=index
    }

})
//*******招聘**********
postJob.addEventListener('click',function(e){
    
    // 显示弹窗
    document.getElementById('overlay').style.display = 'block'; // 显示遮罩层
    jobPop.style.display='block'
})
}
//点击提交事件
function submitApply (){
//*******应聘**********
    applySubmit.addEventListener('click',function(){
        //姓名和联系方式
        let applicantName =applicant.value
        let email=contactWay.value
        let vintroduce=introduce.value
        // 姓名和联系方式不能为空
        if(applicantName&&email&&vintroduce){
             let tempObj={
                applicantName:applicantName,
                position:postJobList[jobIndex].job,
                contactWay:email,
                introduce:vintroduce
            }
            console.log(tempObj)
            reqFunctions.reqAddApplicant(tempObj)
            //关闭弹窗
            applicant.value=''
            contactWay.value=''
            introduce.value=''
            pop.style.display = 'none'
            document.getElementById('overlay').style.display = 'none'; // 隐藏遮罩层
        }else{
            alert('不能为空')
        }
    })
//*******招聘**********
    jobApplySubmit.addEventListener('click',function(){
        let vjob =job.value
        let vdescription=description.value
        let vrequirement=requirement.value
        let vemail=email.value
        // 姓名和联系方式不能为空
        if(vjob&&vdescription&&vrequirement&&vemail){
            let tempObj={
                job:vjob,
                description:vdescription,
                requirement:vrequirement,
                email:vemail
            }
            reqFunctions.reqAddPost(tempObj)
            //关闭弹窗
            job.value=''
            description.value=''
            requirement.value=''
            jobPop.style.display = 'none'
            document.getElementById('overlay').style.display = 'none'; // 隐藏遮罩层
        }else{
            alert('不能为空')
        }
    })
}
//点击取消事件
function submitCancel(){
    cancelSubmit.addEventListener('click',function(){
        applicant.value=''
        contactWay.value=''
        introduce.value=''
        pop.style.display = 'none'
        document.getElementById('overlay').style.display = 'none'; // 隐藏遮罩层
    })
    jobCancelSubmit.addEventListener('click',function(){
        job.value=''
        description.value=''
        requirement.value=''
        jobPop.style.display = 'none'
        document.getElementById('overlay').style.display = 'none'; // 隐藏遮罩层
    })
}



//入口函数
function postAndApplyMain(){
    reqFunctions.reqPostInfo()
    reqFunctions.reqApplicantInfo()

    showApplyList()
    clickApply()
    submitApply()
    submitCancel()

}

postAndApplyMain()

