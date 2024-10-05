let isLoggedIn = false; // 用户登录状态

document.addEventListener('DOMContentLoaded', function () {
    const loginButton = document.getElementById('loginButton');
    const loginModal = document.getElementById('loginModal');
    const closeButton = document.querySelector('.close');
    const loginForm = document.getElementById('loginForm');

    // 点击登录按钮显示登录模态框
    loginButton.addEventListener('click', function() {
        loginModal.style.display = 'block';
    });

    // 点击关闭按钮或模态框外部隐藏登录模态框
    closeButton.addEventListener('click', function() {
        loginModal.style.display = 'none';
    });

    // 点击模态框外部隐藏登录模态框
    window.addEventListener('click', function(event) {
        if (event.target === loginModal) {
            loginModal.style.display = 'none';
        }
    });

    // 阻止表单默认提交行为，处理登录过程
    loginForm.addEventListener('submit', function(event) {
        event.preventDefault();

        const account = loginForm.elements['account'].value;
        const password = loginForm.elements['password'].value;

        // 发起 AJAX 请求与后端交互
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '/login', true);
        xhr.setRequestHeader('Content-Type', 'application/json');

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);
                    if (response.success) {
                        // 登录成功的处理
                        isLoggedIn = true;
                        loginModal.style.display = 'none';
                        alert('登录成功！');

                        if (response.rights === "normal") {
                            document.querySelector('.login-section').style.display = 'block';
                            document.getElementById("performance-evaluation").style.display = "none";
                            document.querySelector('.cards-container').style.display = "flex";
                            document.getElementById("generate-report").style.display = "inline-block";
                            document.getElementById('eva-scores-content').style.display = "none";

                            // 更新个人信息
                            document.getElementById('teacher_id').textContent = response.userid;
                            document.getElementById('teacher_name').textContent = response.username;
                            document.getElementById('teacher_email').textContent = response.email;
                            document.getElementById('teacher_phone').textContent = response.phone; 
                            document.getElementById('teacher_title').textContent = response.title;
                            document.getElementById('teacher_faculty').textContent = response.faculty;
                            document.getElementById('teacher_tenure').textContent = response.teaching_years;
                            document.getElementById('teacher_photo').src = response.photoUrl;

                            document.getElementById('info_id').textContent = response.userid;
                            document.getElementById('info_name').textContent = response.username;
                            document.getElementById('info_email').textContent = response.email;
                            document.getElementById('info_phone').textContent = response.phone; 
                            document.getElementById('info_title').textContent = response.title;
                            document.getElementById('info_faculty').textContent = response.faculty;
                            document.getElementById('info_tenure').textContent = response.teaching_years;
                            document.getElementById('info_photo').src = response.photoUrl;
                        }
                        else if (response.rights === "admin") {
                            document.querySelector('.login-section').style.display = 'none';
                            document.querySelector('.cards-container').style.display = "none";
                            document.getElementById("performance-evaluation").style.display = "none";
                            document.getElementById('eva-scores-content').style.display = "";

                            loadEvaluationTable();
                        }
                    } else {
                        // 登录失败的处理
                        alert('用户名或密码错误，请重试。');
                    }
                } else {
                    // 请求错误的处理
                    alert('用户名或密码错误，请重试。');
                }
            }
        };

        const data = JSON.stringify({ account: account, password: password });
        xhr.send(data);
    });
});




