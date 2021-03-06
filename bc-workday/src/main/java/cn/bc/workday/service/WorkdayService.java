package cn.bc.workday.service;

import java.util.Date;

import cn.bc.core.service.CrudService;
import cn.bc.workday.domain.Workday;

public interface WorkdayService extends CrudService<Workday>{

	/**
	 * 检查开始日期和结束日期是否出现时间交叉
	 * @param fromDate  开始日期
	 * @param toDate  结束日期
	 */
	boolean checkDateIsCross(Date fromDate, Date toDate);
	
	/**
	 * 检查开始日期和结束日期是否出现时间交叉
	 * @param id  编辑状态时的id
	 * @param fromDate  开始日期
	 * @param toDate  结束日期
	 */
	boolean checkDateIsCross(long id, Date fromDate, Date toDate);
	
	/**
	 * 回去指定时间段内的实际工作日的天数
	 * @param fromDate  开始时间
	 * @param toDate  结束时间
	 * @param workdaysEveryWeeks 每周的工作日天数，默认是5
	 * @return
	 */
	int getRealWorkingdays(Date fromDate, Date toDate, int workdaysEveryWeeks);
}
