// 监听页面滚动事件
window.addEventListener('scroll', reveal);

function reveal() {
    var reveals = document.querySelectorAll('.feature');

    for (var i = 0; i < reveals.length; i++) {
        var windowHeight = window.innerHeight;
        var elementTop = reveals[i].getBoundingClientRect().top;
        var elementVisible = 100; // 元素距离视窗顶部150px时触发

        if (elementTop < windowHeight - elementVisible) {
            reveals[i].classList.add('active');
        } else {
            reveals[i].classList.remove('active');
        }
    }
}

const sidebar = document.querySelector('.sidebar');
const mainContent = document.querySelector('.main-content');

// 定义侧边栏显示/隐藏的函数
function showSidebar() {
    sidebar.style.left = '0';
    mainContent.style.marginLeft = '300px'; // 调整为侧边栏宽度
    mainContent.style.marginRight = '50px';
}

function hideSidebar() {
    sidebar.style.left = '-250px';
    mainContent.style.marginLeft = '100px';
    mainContent.style.marginRight = '100px';
}

document.addEventListener('DOMContentLoaded', function () {
    // 监听鼠标移入事件
    document.addEventListener('mousemove', function(event) {
        if (event.clientX < 20 && isLoggedIn) {
            showSidebar();
        } else if (event.clientX > 250) {
            hideSidebar();
        }
    });

    // 监听侧边栏鼠标移入/移出事件
    sidebar.addEventListener('mouseenter', showSidebar);
    sidebar.addEventListener('mouseleave', function(event) {
        if (event.clientX > 250) {
            hideSidebar();
        }
    });

    // 监听侧边栏内部元素的点击事件
    sidebar.addEventListener('click', function(event) {
        const target = event.target;
        if (target.tagName === 'A') {
            const targetContentId = target.getAttribute('data-target');
            const targetContent = document.getElementById(targetContentId);
            if (targetContent) {
                // 隐藏所有内容部分，然后显示目标内容
                mainContent.querySelectorAll('.content-section').forEach(function(content) {
                    content.classList.remove('active');
                });
                targetContent.classList.add('active');
            }
        }
    });
});

function toggleSidebar() {
    if (isLoggedIn) {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('active'); // 切换侧边栏的活动状态
    }
}

reveal(); // 页面加载时也尝试执行一次reveal，以确保处于视窗中的元素正确显示
