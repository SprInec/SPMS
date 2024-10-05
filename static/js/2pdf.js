document.getElementById('export-pdf').addEventListener('click', function () {
    const { jsPDF } = window.jspdf;
    // 隐藏不想在PDF中显示的元素
    document.getElementById('export-pdf').style.display = 'none';

    // 创建一个新的jsPDF实例
    const doc = new jsPDF({
        orientation: 'portrait',
        unit: 'pt',
        format: 'a4'
    });

    // 使用html2canvas库来捕获div内容并渲染到PDF中
    html2canvas(document.querySelector('.performance-evaluation'), { scale: 2, useCORS: true}).then(canvas => {
        // 恢复隐藏的元素
        document.getElementById('export-pdf').style.display = 'inline-block';

        const imgData = canvas.toDataURL('image/png');
        const imgProps = doc.getImageProperties(imgData);
        const pdfWidth = doc.internal.pageSize.getWidth();
        const pdfHeight = doc.internal.pageSize.getHeight();
        const contentAspectRatio = imgProps.width / imgProps.height;
        
        let finalWidth, finalHeight;

        // 根据内容和PDF的宽高比来确定最终尺寸，以确保内容能够在一个页面内居中显示
        if (contentAspectRatio > 1) {
            // 内容宽度大于高度
            finalWidth = pdfWidth;
            finalHeight = finalWidth / contentAspectRatio;
        } else {
            // 内容高度大于或等于宽度
            finalHeight = pdfHeight;
            finalWidth = finalHeight * (contentAspectRatio + 0.07);
        }

        // 调整最终尺寸以确保内容居中
        let xPosition = (pdfWidth - finalWidth) / 2;
        let yPosition = (pdfHeight - finalHeight) / 2;

        // 由于内容需要在一个页面内显示，不需要循环添加页面
        doc.addImage(imgData, 'PNG', xPosition, yPosition, finalWidth, finalHeight);

        doc.save('performance-evaluation.pdf');
    });
});
