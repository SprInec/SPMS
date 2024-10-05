document.addEventListener('DOMContentLoaded', function() {
    const links = document.querySelectorAll('.sidebar a');
    links.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault(); // 阻止链接默认行为
            const targetId = this.getAttribute('data-target');
            const targetContent = document.getElementById(targetId);

            // 隐藏所有内容部分
            document.querySelectorAll('.content-section').forEach(section => {
                section.style.display = 'none';
            });

            // 显示点击链接对应的内容部分
            if (targetContent) {
                targetContent.style.display = 'block';
            }
        });
    });
});
