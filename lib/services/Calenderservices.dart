 class Mycalender{
  static String getWeeknamefromNumber({required int weeknum}){
    List<String> listofweek=['MON','TUE','WED','THU','FRI','SAT','SUN'];
    return listofweek[weeknum-1];
 }

 static String getMonthnamefromNumber({required int monthnum}){
    List<String> listofmonth=['Jan','Feb','March','April','May','June','July','Aug','Sep','Oct','Nov','Dec'];
    return listofmonth[monthnum-1];
 }

 static String getDateinSlash({required DateTime date}){
    String dateinslash="${date.day}/${date.month}/${date.year}";
    return dateinslash;
 }

  static String getDateindash({required DateTime date}){
    String dateindash="${date.day}-${date.month}-${date.year}";
    return dateindash;
  }

  static String getMonthinTwodigits({required DateTime dateTime}){
    String monthval=dateTime.month.toString();
    if((monthval.length)==1){
       monthval="0$monthval";
    }
    return monthval;
    }

}