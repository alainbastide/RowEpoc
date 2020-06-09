function autoRange(serie){
    var seriesCount =serie.count;
    axisX.min = serie.at(0).x;
    axisX.max = serie.at(0).x;
    axisY.min = serie.at(0).y;
    axisY.max = serie.at(0).y;
    for(var i = 1;i < seriesCount;i ++)
    {
        axisX.min = Math.min(axisX.min,serie.at(i).x);
        axisX.max = Math.max(axisX.max,serie.at(i).x);
        axisY.min = Math.min(axisY.min,serie.at(i).y);
        axisY.max = Math.max(axisY.max,serie.at(i).y);
    }

    axisX.min -=0.;
    axisX.max +=0.;

//    axisY.min -=5.;
//    axisY.max +=5.;

    axisY.min -=5.;
    axisY.max +=5.;

    return 0;
}

function minMaxRange(serie){
    var seriesCount =serie.count;
    var minX = serie.at(0).x;
    var maxX = serie.at(0).x;
    var minY = serie.at(0).y;
    var maxY = serie.at(0).y;
    for(var i = 1;i < seriesCount;i ++)
    {
        minX = Math.min(minX,serie.at(i).x);
        maxX = Math.max(maxX,serie.at(i).x);
        minY = Math.min(minY,serie.at(i).y);
        maxY = Math.max(maxY,serie.at(i).y);
    }



    return [minX,maxX,minY,maxY];
}


function entierAleatoire(min, max)
{
 return Math.floor(Math.random() * (max - min + 1)) + min;
}
