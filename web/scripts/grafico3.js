let cat = document.getElementsByName("cat");
if (cat.length > 1) {
    let vlr = document.getElementsByName("vlr");
    let labelsX = [];
    let dataX = [];
    for (var i = 0; i < cat.length; i++) {
        labelsX[i] = cat[i].value;
        dataX[i] = vlr[i].value;
    }
    let colorsX = ['#49A9EA', '#36CAAB', '#FFD700', '#FF69B4', '#64E572', '#FF9655', '#FFFF00', '#AC5353',
        '#4B0082', '#D8BFD8', '#2E8B57', '#BDB76B', '#6B8E23', '#7B68EE', '#EE82EE', '#CFD4D8'];

    let myChart3 = document.getElementById("myChart3").getContext('2d');

    let chart3 = new Chart(myChart3, {
        type: 'doughnut',
        data: {
            labels: labelsX,
            datasets: [{
                    data: dataX,
                    backgroundColor: colorsX
                }]
        },
        options: {
            title: {
                text: '"Resumo da Opera"',
                display: true
            }
        }
    });
}
