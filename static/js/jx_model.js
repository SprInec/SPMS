document.addEventListener('DOMContentLoaded', function() {
    // 获取模态框和关闭按钮元素
    var modal = document.getElementById("jx-modal");
    var closeBtn = document.getElementsByClassName("jx-close")[0];

    // 给每个卡片添加点击事件监听器
    document.querySelectorAll('.card').forEach(function(card) {
        card.addEventListener('click', function() {
            // 显示模态框
            modal.style.display = "block";
            
            // 根据点击的卡片类型，动态更改模态框内容
            var modalBody = document.getElementById("jx-modal-body");
            
            switch(card.id) {
                case "tchachi-scores":
                    modalBody.innerHTML = `
                        <div class="jx-teaching-achievement-card">
                            <p>请填写所教课程本学期的详细成绩信息。</p>
                            <form id="teaching-achievement-form">
                                <div>
                                    <label for="subject">任教科目:</label>
                                    <input type="text" id="subject" name="subject" required>
                                </div>
                                <div>
                                    <label for="average">平均成绩:</label>
                                    <input type="number" id="average" name="average" step="0.01" min="0" max="100" required>
                                </div>
                                <div>
                                    <label for="highest">及格率:</label>
                                    <input type="number" id="highest" name="highest" min="0" max="100" required>
                                </div>
                                <div style="text-align: right; margin-top: 20px;">
                                    <button type="submit">提交</button>
                                </div>
                            </form>
                        </div>
                    `;
                    bindFormSubmitEvent_ta();
                    break;

                case "initial-performance":
                    modalBody.innerHTML = `
                        <div class="jx-performance-card" style="padding: 10px;">
                            <p style="margin-bottom: 20px;">请填写学期初的绩效目标。</p>
                            <form id="initial-performance-form" style="margin-bottom: 10px;">
                                <div style="margin-bottom: 10px;">
                                    <label for="semester-start">学期开始:</label>
                                    <input type="date" id="semester-start" name="semester-start" required style="border-radius: 15px; border: 1px solid #cccccc; padding: 10px; outline: none; box-shadow: 0 3px 6px rgba(0,0,0,0.1); transition: all 0.3s ease;">

                                    <style>
                                        #semester-start:hover {
                                            border-color: #007bff; /* 鼠标悬停时边框颜色变化 */
                                        }
                                        #semester-start:focus {
                                            border-color: #007bff; /* 输入框聚焦时边框颜色变化 */
                                            box-shadow: 0 0 0 2px rgba(0,123,255,.25); /* 添加聚焦时的阴影效果 */
                                        }
                                    </style>
                                </div>
                                <div style="margin-bottom: 10px;">
                                    <label for="semester-end">学期结束:</label>
                                    <input type="date" id="semester-end" name="semester-end" required style="border-radius: 15px; border: 1px solid #cccccc; padding: 10px; outline: none; box-shadow: 0 3px 6px rgba(0,0,0,0.1); transition: all 0.3s ease;">

                                    <style>
                                        #semester-end:hover {
                                            border-color: #007bff; /* 鼠标悬停时边框颜色变化 */
                                        }
                                        #semester-end:focus {
                                            border-color: #007bff; /* 输入框聚焦时边框颜色变化 */
                                            box-shadow: 0 0 0 2px rgba(0,123,255,.25); /* 添加聚焦时的阴影效果 */
                                        }
                                    </style>
                                </div>
                                <div style="margin-bottom: 20px;">
                                    <h3 style="margin-bottom: 10px;">绩效目标</h3>
                                    <textarea name="performanceTarget" rows="4"  placeholder="在这里填写您的绩效目标..." style=" width: 100%;" required></textarea>
                                </div>
                                <div style="text-align: right;">
                                    <button type="submit">提交</button>
                                </div>
                            </form>
                        </div>
                    `;
                    bindFormSubmitEvent_ip();
                    // 添加表单提交事件监听
                
                    break;

                case "student-feedback":
                    modalBody.innerHTML = `
                        <div class="jx-stu-feedback-card">
                            <p>学生反馈与评价：</p>
                            <form id="student-feedback-form">
                                <!-- 教学方法 -->
                                <p>问题一: 该教师的授课方式是否易于理解？</p>
                                <select name="teachingMethod" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不同意</option>
                                    <option value="2">不同意</option>
                                    <option value="3">一般</option>
                                    <option value="4">同意</option>
                                    <option value="5">非常同意</option>
                                </select>

                                <!-- 互动与参与 -->
                                <p>问题二: 该教师是否鼓励学生提问和参与课堂讨论？</p>
                                <select name="classParticipation" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不同意</option>
                                    <option value="2">不同意</option>
                                    <option value="3">一般</option>
                                    <option value="4">同意</option>
                                    <option value="5">非常同意</option>
                                </select>

                                <!-- 课程内容 -->
                                <p>问题三: 课程内容是否符合你的学习预期和目标？</p>
                                <select name="courseContent" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不同意</option>
                                    <option value="2">不同意</option>
                                    <option value="3">一般</option>
                                    <option value="4">同意</option>
                                    <option value="5">非常同意</option>
                                </select>

                                <!-- 评估与反馈 -->
                                <p>问题四: 该教师的评估方法是否公平且有助于学习？</p>
                                <select name="assessmentFeedback" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不同意</option>
                                    <option value="2">不同意</option>
                                    <option value="3">一般</option>
                                    <option value="4">同意</option>
                                    <option value="5">非常同意</option>
                                </select>

                                <!-- 教师态度 -->
                                <p>问题五: 该教师对待学生是否公正、尊重？</p>
                                <select name="teacherAttitude" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不同意</option>
                                    <option value="2">不同意</option>
                                    <option value="3">一般</option>
                                    <option value="4">同意</option>
                                    <option value="5">非常同意</option>
                                </select>

                                <p>其他意见（可选）:</p>
                                <textarea name="additionalComments" rows="4" placeholder="如果您有其他意见或建议，请在此填写。"></textarea>

                                <div style="text-align: right; margin-top: 20px;">
                                    <button type="submit">提交反馈</button>
                                </div>
                            </form>
                        </div>
                    `;
                    bindFormSubmitEvent_stu();
                    break;

                case "colleague-feedback":
                    modalBody.innerHTML = `
                        <div class="jx-col-feedback-card">
                            <p>请填写同事反馈与评价。</p>
                            <form id="colleague-feedback-form">
                                <p>问题一: 该教师在其专业领域的知识和技能方面是否表现出卓越？</p>
                                <select name="professionalExcellence1" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不满意</option>
                                    <option value="2">不满意</option>
                                    <option value="3">一般</option>
                                    <option value="4">满意</option>
                                    <option value="5">非常满意</option>
                                </select>

                                <p>问题二: 该教师是否能有效地将理论知识应用于实践中？</p>
                                <select name="theoryToPractice1" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不满意</option>
                                    <option value="2">不满意</option>
                                    <option value="3">一般</option>
                                    <option value="4">满意</option>
                                    <option value="5">非常满意</option>
                                </select>

                                <p>问题三: 该教师的教学方法是否能够激发学生的学习兴趣和参与度？</p>
                                <select name="professionalExcellence2" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不满意</option>
                                    <option value="2">不满意</option>
                                    <option value="3">一般</option>
                                    <option value="4">满意</option>
                                    <option value="5">非常满意</option>
                                </select>

                                <p>问题四: 该教师是否能公平、有效地评估学生的学习成果？</p>
                                <select name="theoryToPractice2" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不满意</option>
                                    <option value="2">不满意</option>
                                    <option value="3">一般</option>
                                    <option value="4">满意</option>
                                    <option value="5">非常满意</option>
                                </select>
                
                                <p>问题五: 该教师是否愿意与同事分享教学经验和资源？</p>
                                <select name="professionalExcellence3" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不满意</option>
                                    <option value="2">不满意</option>
                                    <option value="3">一般</option>
                                    <option value="4">满意</option>
                                    <option value="5">非常满意</option>
                                </select>

                                <p>问题六:该教师是否对教学方法和课程内容进行创新和改进？</p>
                                <select name="professionalExcellence4" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不满意</option>
                                    <option value="2">不满意</option>
                                    <option value="3">一般</option>
                                    <option value="4">满意</option>
                                    <option value="5">非常满意</option>
                                </select>

                                <p>问题七:该教师是否愿意尝试新技术或新策略以提高教学效果？</p>
                                <select name="theoryToPractice3" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不满意</option>
                                    <option value="2">不满意</option>
                                    <option value="3">一般</option>
                                    <option value="4">满意</option>
                                    <option value="5">非常满意</option>
                                </select>

                                <p>综合评价:</p>
                                <textarea name="colleague-feedback" rows="5" placeholder="请输入您的反馈和评价..."></textarea>
                                <div style="text-align: right; margin-top: 20px;">
                                    <button type="submit">提交</button>
                                </div>
                            </form>
                        </div>
                    `;
                    bindFormSubmitEvent_cf();
                    break;

                case "leader-evaluation":
                    modalBody.innerHTML = `
                        <div class="jx-leader-eval-card">
                            <form id="leader-evaluation-form"> 
                                <p>请填写任课组长评价。</p>
                                <p>问题1: 教学内容的组织和呈现:</p>
                                <select name="question1" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不满意</option>
                                    <option value="2">不满意</option>
                                    <option value="3">一般</option>
                                    <option value="4">满意</option>
                                    <option value="5">非常满意</option>
                                </select>

                                <p>问题2: 课堂互动与参与:</p>
                                <select name="question2" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不满意</option>
                                    <option value="2">不满意</option>
                                    <option value="3">一般</option>
                                    <option value="4">满意</option>
                                    <option value="5">非常满意</option>
                                </select>

                                <p>问题3: 课程内容是否符合学习目标和学生的需求:</p>
                                <select name="question3" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不满意</option>
                                    <option value="2">不满意</option>
                                    <option value="3">一般</option>
                                    <option value="4">满意</option>
                                    <option value="5">非常满意</option>
                                </select>

                                <p>问题4: 教师设定的课程目标是否明确、具体且可衡量:</p>
                                <select name="question4" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不满意</option>
                                    <option value="2">不满意</option>
                                    <option value="3">一般</option>
                                    <option value="4">满意</option>
                                    <option value="5">非常满意</option>
                                </select>

                                <p>问题5: 课程设计是否包括小组讨论、项目工作、案例研究等多样化的学习活动:</p>
                                <select name="question5" required>
                                    <option value="">请选择</option>
                                    <option value="1">非常不满意</option>
                                    <option value="2">不满意</option>
                                    <option value="3">一般</option>
                                    <option value="4">满意</option>
                                    <option value="5">非常满意</option>
                                </select>
                                
                                <p>绩效目标完成情况:</p>
                                <select name="target-completion" required>
                                    <option value="">请选择</option>
                                    <option value="1">20%</option>
                                    <option value="2">40%</option>
                                    <option value="3">60%</option>
                                    <option value="4">80%</option>
                                    <option value="5">100%</option>
                                </select>

                                <p>综合评价:</p>
                                <textarea name="leader-evaluation" rows="5" placeholder="请输入您的评价..."></textarea>
                                <div style="text-align: right; margin-top: 20px;">
                                    <button type="submit">提交</button>
                                </div>
                            </form>
                        </div>
                    `;
                    bindFormSubmitEvent_le();
                    break;

                case "self-summary":
                    modalBody.innerHTML = `
                        <div class="jx-self-summary-card">
                            <form id="self-summary-form">
                                <p>请填写本学期教师本人回顾总结。</p>
                                <h3>本学期参与培训记录(包含专业发展课程、研讨会等)</h3>
                                <p>参与培训次数:</p>
                                <input type="number" id="session-count" name="session-count" min="0" required>
                                <p>参与培训列举:</p>
                                <textarea name="sessionList" rows="5" placeholder="请在此填写本学期参会记录..."></textarea>
                                <h3>本学期科研成果(包含课题、论文、专利等)</h3>
                                <p>科研成果数量:</p>
                                <input type="number" id="research-count" name="research-count" min="0" required>
                                <p>科研成果列举:</p>
                                <textarea name="researchResults" rows="5" placeholder="请在此填写本学期科研成果..."></textarea>
                                <h3>回顾总结</h3>
                                <textarea name="selfSummary" rows="10" placeholder="请在这里填写您的回顾总结..."></textarea>
                                <div style="text-align: right; margin-top: 20px;">
                                    <button type="submit">提交</button>
                                </div>
                            </form>
                        </div>
                    `;
                    bindFormSubmitEvent_ss();
                    break;
                
                default:
                    modalBody.innerHTML = "<p>未知卡片，请刷新页面重试。</p>";
            }
        });
    });

    // 点击关闭按钮隐藏模态框
    closeBtn.onclick = function() {
        modal.style.display = "none";
    }

    // 点击模态框外部区域也可以关闭模态框
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});

var form_1 = 0
var form_2 = 0
var form_3 = 0
var form_4 = 0
var form_5 = 0
var form_6 = 0

// 绑定teaching-achievement-form表单提交事件
function bindFormSubmitEvent_ta() {
    var achievementForm = document.getElementById("teaching-achievement-form");
    if (achievementForm) {
        achievementForm.onsubmit = function(e) {
            e.preventDefault(); // 阻止表单的默认提交行为

            // 创建FormData对象，从teaching-achievement-form表单获取数据
            var formData = new FormData(achievementForm);

            // 从id为teacher_id的span中获取id，用于提交给后台
            var teacherId = document.getElementById("teacher_id").innerText;

            // 添加教师ID到formData
            formData.append("teacher_id", teacherId);

            // 创建XMLHttpRequest对象，发送数据到服务器
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/submit-achievement", true);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    alert("教学成果提交成功！");
                    form_1 = 1;
                    
                    // 提交成功后关闭该jx-modal
                    document.getElementById("jx-modal").style.display = "none";
                } else {
                    alert("提交教学成果时发生错误。");
                }
            };
            xhr.send(formData);
        };
    } else {
        console.error("未找到ID为'teaching-achievement-form'的表单元素。请检查该元素是否存在以及ID是否正确。");
    }
}

// 绑定initial-performance-form表单提交事件
function bindFormSubmitEvent_ip() {
    var performanceForm = document.getElementById("initial-performance-form");
    if (performanceForm) {
        performanceForm.onsubmit = function (e) {
            
            e.preventDefault(); // 阻止表单的默认提交行为

            // 创建FormData对象，从initial-performance-form表单获取数据
            var formData = new FormData(performanceForm);

            // 从id为teacher_id的span中获取id，用于提交给后台
            var teacherId = document.getElementById("teacher_id").innerText;

            // 添加教师ID到formData
            formData.append("teacher_id", teacherId);

            // 创建XMLHttpRequest对象，发送数据到服务器
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/submit-performance", true);
            xhr.onload = function () {
                if (xhr.status === 200) {
                    alert("初始绩效提交成功！");
                    form_2 = 1;
                    // 提交成功后关闭该jx-modal
                    document.getElementById("jx-modal").style.display = "none";
                } else {
                    alert("提交初始绩效时发生错误。");
                }
            };
            xhr.send(formData);
        };
    } else {
        console.error("未找到ID为'initial-performance-form'的表单元素。请检查该元素是否存在以及ID是否正确。");
    }
}

// 绑定student-feedback-form表单提交事件
function bindFormSubmitEvent_stu() {
    var feedbackForm = document.getElementById("student-feedback-form");
    if (feedbackForm) {
        feedbackForm.onsubmit = function(e) {
            e.preventDefault(); // 阻止表单的默认提交行为

            // 创建FormData对象，从student-feedback-formn表单获取数据
            var formData = new FormData(feedbackForm);

            // 从id为teacher_id的span中获取id，用于提交给后台
            var teacherId = document.getElementById("teacher_id").innerText;

            // 添加教师ID到formData
            formData.append("teacher_id", teacherId);

            // 创建XMLHttpRequest对象，发送数据到服务器
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/submit-feedback", true);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    alert("反馈提交成功！");
                    form_3 = 1;
                    // 提交成功后关闭该jx-modal
                    document.getElementById("jx-modal").style.display = "none";
                } else {
                    alert("提交反馈时发生错误。");
                }
            };
            xhr.send(formData);
        };
    } else {
        console.error("未找到ID为'student-feedback-form'的表单元素。请检查该元素是否存在以及ID是否正确。");
    }
}

// 绑定colleague-feedback-form表单提交事件
function bindFormSubmitEvent_cf() {
    var feedbackForm = document.getElementById("colleague-feedback-form");
    if (feedbackForm) {
        feedbackForm.onsubmit = function(e) {
            e.preventDefault(); // 阻止表单的默认提交行为

            // 创建FormData对象，从colleague-feedback-form表单获取数据
            var formData = new FormData(feedbackForm);

            // 从id为teacher_id的span中获取id，用于提交给后台
            var teacherId = document.getElementById("teacher_id").innerText;

            // 添加教师ID到formData
            formData.append("teacher_id", teacherId);

            // 创建XMLHttpRequest对象，发送数据到服务器
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/submit-colleague-feedback", true);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    alert("同事反馈提交成功！");
                    form_4 = 1;
                    // 提交成功后关闭该jx-modal
                    document.getElementById("jx-modal").style.display = "none";
                } else {
                    alert("提交同事反馈时发生错误。");
                }
            };
            xhr.send(formData);
        };
    } else {
        console.error("未找到ID为'colleague-feedback-form'的表单元素。请检查该元素是否存在以及ID是否正确。");
    }
}

// 绑定leader-evaluation-form表单提交事件
function bindFormSubmitEvent_le() {
    var evaluationForm = document.getElementById("leader-evaluation-form");
    if (evaluationForm) {
        evaluationForm.onsubmit = function(e) {
            e.preventDefault(); // 阻止表单的默认提交行为

            // 创建FormData对象，从leader-evaluation-form表单获取数据
            var formData = new FormData(evaluationForm);

            // 从id为teacher_id的span中获取id，用于提交给后台
            var teacherId = document.getElementById("teacher_id").innerText;

            // 添加教师ID到formData
            formData.append("teacher_id", teacherId);

            // 创建XMLHttpRequest对象，发送数据到服务器
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/submit-leader-evaluation", true);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    alert("任课组长评价提交成功！");
                    form_5 = 1;
                    // 提交成功后关闭该jx-modal
                    document.getElementById("jx-modal").style.display = "none";
                } else {
                    alert("提交任课组长评价时发生错误。");
                }
            };
            xhr.send(formData);
        };
    } else {
        console.error("未找到ID为'leader-evaluation-form'的表单元素。请检查该元素是否存在以及ID是否正确。");
    }    
}

// 绑定self-summary-form表单提交事件
function bindFormSubmitEvent_ss() {
    var summaryForm = document.getElementById("self-summary-form");
    if (summaryForm) {
        summaryForm.onsubmit = function(e) {
            e.preventDefault(); // 阻止表单的默认提交行为

            // 创建FormData对象，从self-summary-form表单获取数据
            var formData = new FormData(summaryForm);

            // 从id为teacher_id的span中获取id，用于提交给后台
            var teacherId = document.getElementById("teacher_id").innerText;

            // 添加教师ID到formData
            formData.append("teacher_id", teacherId);

            // 创建XMLHttpRequest对象，发送数据到服务器
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "/submit-self-summary", true);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    alert("回顾总结提交成功！");
                    form_6 = 1;
                    // 提交成功后关闭该jx-modal
                    document.getElementById("jx-modal").style.display = "none";
                } else {
                    alert("提交回顾总结时发生错误。");
                }
            };
            xhr.send(formData);
        };
    } else {
        console.error("未找到ID为'self-summary-form'的表单元素。请检查该元素是否存在以及ID是否正确。");
    }
}

// document.addEventListener('DOMContentLoaded', (event) => {
//     const reportButton = document.getElementById('generate-report');
//     if (reportButton) {
//         reportButton.addEventListener('click', generateTeacherReport);
//     }
// });

function generateTeacherReport() {
    const teacherId = document.getElementById("teacher_id").innerText.trim();

    if (!teacherId) {
        console.error('教师ID未找到或为空。');
        return;
    }

    // 隐藏提交按钮,显示加载动画
    document.getElementById("generate-report").style.display = "none";
    document.getElementById("loading-animation").style.display = "block";

    fetch(`/generate-teacher-report/${teacherId}`, {
        method: 'GET',
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('网络响应错误');
        }
        return response.json();
    })
    .then(data => {
        if (data.message === '请先提交教师相关绩效表单。') {
            alert(data.message);
            document.getElementById("generate-report").style.display = "inline-block";
            document.getElementById("loading-animation").style.display = "none";
            return;
        }

        document.querySelector('.login-section').style.display = 'none';
        document.querySelector('.cards-container').style.display = 'none';
        document.getElementById("loading-animation").style.display = "none";
        
        // 将class "performance-evaluation"的display状态更改为显示
        document.getElementById("performance-evaluation").style.display = "block";
        
        alert("绩效评估报告生成成功！");
        // 填充数据到页面的逻辑...
        document.getElementById("form-average-score").textContent = data.average_score * 10;
        document.getElementById("form-pass-rate").textContent = data.pass_rate / 0.15 + "%";
        document.getElementById("form-performance-target").textContent = data.per_target;
        document.getElementById("form-student-feedback").textContent = data.stu_feedback;
        document.getElementById("form-colleague-feedback").textContent = data.col_feedback;
        document.getElementById("form-leader-evaluation").textContent = data.leader_eval;
        document.getElementById("form-self-summary").textContent = data.self_review;

        document.getElementById("form-cts").textContent = data.cts;
        document.getElementById("form-cdp").textContent = data.cdp;
        document.getElementById("form-se").textContent = data.se;
        document.getElementById("form-avg").textContent = data.avg;
        document.getElementById("form-pr").textContent = data.pr;
        document.getElementById("form-ce").textContent = data.ce;
        document.getElementById("form-ri").textContent = data.ri;
        document.getElementById("form-coe").textContent = data.coe;
        document.getElementById("form-tpt").textContent = data.tpt;
        document.getElementById("form-total-score").textContent = data.total_score.toFixed(2); // 保留两位小数

        var aiAnswer_1 = marked.parse(data.ai_answer_1);
        var aiAnswer_2 = marked.parse(data.ai_answer_2);

        document.getElementById("form-overall-view").innerHTML = aiAnswer_1;
        document.getElementById("form-development-suggestion").innerHTML = aiAnswer_2;

        const chartData = {
            labels: ['课堂教学能力', '课程设计与规划', '学生评价', '平均成绩', '及格率', '持续教育', '研究与创新', '同事评价', '绩效目标完成情况'],
            datasets: [{
                label: '得分',
                data: [data.cts, data.cdp, data.se, data.avg, data.pr, data.ce, data.ri, data.coe, data.tpt],
                backgroundColor: [
                    'rgba(5, 94, 189, 1)',
                    'rgba(5, 94, 189, 0.9)',
                    'rgba(5, 94, 189, 0.8)',
                    'rgba(5, 94, 189, 0.7)',
                    'rgba(5, 94, 189, 0.6)',
                    'rgba(5, 94, 189, 0.5)',
                    'rgba(5, 94, 189, 0.4)',
                    'rgba(5, 94, 189, 0.3)',
                    'rgba(5, 94, 189, 0.2)'
                ],
                borderColor: 'rgba(5, 94, 189, 1)',
                borderWidth: 1
            }]
        };

        // 计算总得分
        const totalScore = chartData.datasets[0].data.reduce((a, b) => a + b, 0);
        // 计算未得分部分，并转换为数字类型，保留两位小数
        const maxScore = 100; // 假设满分为100
        const unearnedScore = parseFloat((maxScore - totalScore).toFixed(2)); 

        // 如果有未得分，则添加到数据集
        if (unearnedScore > 0) {
            chartData.labels.push('未得分');
            chartData.datasets[0].data.push(unearnedScore);
            chartData.datasets[0].backgroundColor.push('rgba(211,211,211,0.5)');
        }

        const ctx = document.getElementById('form-chart').getContext('2d');
        const myChart = new Chart(ctx, {
            type: 'doughnut',
            data: chartData,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                layout: {
                    padding: {
                        left: 200,
                        right: 100,
                        top: 20,
                        bottom: 20
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'left',
                        labels: {
                            boxWidth: 20,
                            usePointStyle: false
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed !== undefined) {
                                    label += context.parsed + ' 分';
                                }
                                return label;
                            }
                        }
                    }
                },
                animation: {
                    // 动画完成时的回调函数
                    onComplete: () => console.log('动画完成!'),
                    // 动画持续时间5000毫秒
                    duration: 5000,
                    // 缓动函数
                    easing: 'easeInOutElastic'
                },
                hover: {
                    // 悬停动画持续时间
                    animationDuration: 400,
                    // 悬停模式
                    mode: 'nearest'
                }
            }
        });

        console.log("数据接收成功：" + data); // 确保数据被正确接收
    })
    .catch(error => console.error('发生错误：', error));
}

// 加载考勤记录并显示在表格中
function loadEvaluationTable() {
    const tableBody = document.getElementById('TeacherScoreTableBody');

    // 清空表格内容
    tableBody.innerHTML = '';

    // 发送 GET 请求获取考勤记录
    fetch('/evaluations-scoretable', {
        method: 'GET'
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Failed to fetch scores records');
        }
        return response.json();
    })
    .then(records => {
        records.forEach(record => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${record.teacher_id}</td>
                <td>${record.name}</td>
                <td>${record.title}</td>
                <td>${record.department}</td>
                <td>${record.score}</td>
            `;
            tableBody.appendChild(row);
        });
    })
    .catch(error => {
        console.error('Error:', error);
        alert('加载失败，请重试');
    });
}

function filterEvaScores() {
    //获取输入元素和过滤条件
    const searchInput = document.getElementById('search_eva_scores');
    const filter = searchInput.value.trim().toUpperCase();

    // 获取包含员工列表的表格体
    const tableBody = document.getElementById('TeacherScoreTableBody');
    const rows = tableBody.getElementsByTagName('tr'); 

    // 遍历所有表格行，根据搜索条件显示/隐藏行
    for (let i = 0; i < rows.length; i++) {
        const idColumn = rows[i].getElementsByTagName('td')[0]; // 员工ID所在列的索引
        const nameColumn = rows[i].getElementsByTagName('td')[1]; // 员工姓名所在列的索引
        const positionColumn = rows[i].getElementsByTagName('td')[2]; // 员工职位所在列的索引
        const facultyColumn = rows[i].getElementsByTagName('td')[3]; // 员工学院所在列的索引

        if (nameColumn && positionColumn && idColumn  && facultyColumn) {
            const idValue = idColumn.textContent || idColumn.innerText;
            const nameValue = nameColumn.textContent || nameColumn.innerText;
            const positionValue = positionColumn.textContent || positionColumn.innerText;
            const facultyValue = facultyColumn.textContent || facultyColumn.innerText;

            // 根据是否匹配搜索条件来显示/隐藏行
            if (
                nameValue.toUpperCase().includes(filter) ||
                facultyValue.toUpperCase().includes(filter) ||
                positionValue.toUpperCase().includes(filter) ||
                idValue.trim() === filter.trim() // 使用严格相等比较员工ID
            ) {
                rows[i].style.display = '';
            } else {
                rows[i].style.display = 'none';
            }
        }
    }
}

function sortScores() {
    const tableBody = document.getElementById('TeacherScoreTableBody');
    let rows = Array.from(tableBody.rows);
    const sortOption = document.getElementById('sortOption').value;

    switch (sortOption) {
        case 'asc': // 正序
            rows.sort((a, b) => parseFloat(a.cells[4].innerText) - parseFloat(b.cells[4].innerText));
            break;
        case 'desc': // 倒序
            rows.sort((a, b) => parseFloat(b.cells[4].innerText) - parseFloat(a.cells[4].innerText));
            break;
        case 'default': // 默认，这里我们简单地按照ID排序恢复默认状态
            rows.sort((a, b) => parseFloat(a.cells[0].innerText) - parseFloat(b.cells[0].innerText));
            break;
    }

    // 重新添加排序后的行到表格体
    tableBody.innerHTML = '';
    rows.forEach(row => tableBody.appendChild(row));
}

loadEvaluationTable();