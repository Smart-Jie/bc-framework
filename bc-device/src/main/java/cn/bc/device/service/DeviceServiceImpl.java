package cn.bc.device.service;

import org.springframework.beans.factory.annotation.Autowired;

import cn.bc.core.service.DefaultCrudService;
import cn.bc.device.dao.DeviceDao;
import cn.bc.device.domain.Device;

/**
 * 设备Service的实现
 * 
 * @author hwx
 */
public class DeviceServiceImpl extends DefaultCrudService<Device> implements
		DeviceService {
	private DeviceDao deviceDao;
	
	@Autowired
	public void setDeviceDao(DeviceDao deviceDao) {
		this.deviceDao = deviceDao;
		this.setCrudDao(deviceDao);
	}

	public Long checkDeviceCodeIsExist(String code) {
		return this.deviceDao.checkDeviceCodeIsExist(code);
	}

	public String findDeviceCode(Long id) {
		return this.deviceDao.findDeviceCode(id);
	}
	
}
