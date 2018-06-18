package project.bean;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import lombok.Data;

@Data
public class NoticeDto {
	String receiver,sender,reg;
	int type,read,bno;
	
	//조인용
	String id,nick,profile,auto;
	
	public String getDate() {
		return reg.substring(0, 10);
	}
	
	public String getDate(String today){
		Calendar cal = Calendar.getInstance(); //Calendar 객체
		
		int year = Integer.parseInt(getDate().substring(0,4));
		int month = Integer.parseInt(getDate().substring(5,7));
		int day = Integer.parseInt(getDate().substring(8,10));
		
		long now_day = cal.getTimeInMillis(); //현재 시간

		cal.set(year, month-1, day); //목표일을 cal에 set
		
		long event_day = cal.getTimeInMillis(); //목표일에 대한 시간
		long d_day = (now_day - event_day) / (60*60*24*1000);

		if(d_day<7)
			return String.valueOf(d_day)+"일 전";
		else
			return String.valueOf(d_day/7)+"주 전";
	}
	
	public String getTime() {
		return reg.substring(11, 16);
	}
	
	public String getAuto(){
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		if(getDate().equals(today))
			return getTime();
		else
			return getDate(today);
	}
}
