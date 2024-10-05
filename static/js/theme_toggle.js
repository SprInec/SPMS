document.addEventListener('DOMContentLoaded', () => {
    const themeToggleButton = document.getElementById('theme-toggle');
    
    themeToggleButton.addEventListener('click', () => {
        document.documentElement.classList.toggle('dark-theme');
    });
});
