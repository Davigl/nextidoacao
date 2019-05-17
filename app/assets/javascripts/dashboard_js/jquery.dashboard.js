$( document ).ready(function() {

    var meses;
    var dias;
    var colaboradores = [];
    var colaboradores_values = [];

    $.get("/api/cadastros_mes", function (data){
        meses = [data.janeiro, data.fevereiro, data.marco, data.abril, data.maio, data.junho, data.julho, data.agosto, data.setembro, data.outubro, data.novembro, data.dezembro];
    });

    $.get("/api/cadastros_semana", function (dia){
        dias = [dia.domingo, dia.segunda, dia.terca, dia.quarta, dia.quinta, dia.sexta, dia.sabado];
    });

    $.get("/api/cadastros_colaboradores", function (colaborador){
        colaborador.forEach(function(value, key) {
            colaboradores_values.push(value.count);
            colaboradores.push(value.autor);
        });
    });

    var DrawSparkline = function() {
        $('#sparkline1').sparkline(dias, {
            type: 'bar',
            tooltipFormat: '{{offset:offset}}: {{value}}',
            tooltipValueLookups: {
                'offset': {
                    0: 'Domingo',
                    1: 'Segunda',
                    2: 'Terca',
                    3: 'Quarta',
                    4: 'Quinta',
                    5: 'Sexta',
                    6: 'Sabado'
                }
            },
            height: '200',
            barWidth: '10',
            barSpacing: '5',
            barColor: '#ffffff'
        });

        $('#sparkline2').sparkline(meses, {
            type: 'bar',
            height: '200',
            barWidth: '10',
            barSpacing: '5',
            barColor: '#3bafda',
            tooltipFormat: '{{offset:offset}}: {{value}}',
            tooltipValueLookups: {
                'offset': {
                    0: 'Janeiro ',
                    1: 'Fevereiro',
                    2: 'Março',
                    3: 'Abril ',
                    4: 'Maio ',
                    5: 'Junho ',
                    6: 'Julho ',
                    7: 'Agosto ',
                    8: 'Setembro ',
                    9: 'Outubro ',
                    10: 'Novembro ',
                    11: 'Dezembro '
                }
            }
        });

        $('#sparkline3').sparkline(colaboradores_values, {
            type: 'pie',
            width: '200',
            height: '200',
            sliceColors: ['#CFBDED', '#A4C3C2', '#FAC9B8', '#DB8A74', '#2BC016'],
            tooltipFormat: '{{offset:offset}}: {{value}}',
            tooltipValueLookups: {
                'offset': {
                    0: colaboradores[0],
                    1: colaboradores[1],
                    2: colaboradores[2],
                    3: colaboradores[3],
                    4: colaboradores[4]
                }
            }
        });
    };

    $(window).ready(function(e) {
        DrawSparkline();
        var resizeChart;
        clearTimeout(resizeChart);
        resizeChart = setTimeout(function() {
            DrawSparkline();
        }, 1500);
    });
});