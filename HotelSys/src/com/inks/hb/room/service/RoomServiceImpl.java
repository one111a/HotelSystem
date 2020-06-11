package com.inks.hb.room.service;

import java.sql.SQLException;
import java.util.ArrayList;

import com.inks.hb.room.dao.RoomDao;
import com.inks.hb.room.pojo.Room;

/**
 * 修订：2017.11.23
 * 将异常放在了本层处理
 * 如果出现数据库相关异常，则返回-1或者null
 */
public class RoomServiceImpl implements RoomService {

    private RoomDao dao = new RoomDao();

    @Override
    public int insertRoom(Room room) {
        try {
            String name = room.getRoomId();
            if (queryRepeat(name, name) != 1)
                return 0;
            dao.insertData(room);
        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
            return -1;
        }
        return 1;
    }

    @Override
    public int deleteRoom(String roomId) {
        Room room = new Room();
        room.setRoomId(roomId);;

        try {
            dao.deleteData(room);
        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
            return -1;
        }
        return 1;
    }

    @Override
    public int updateRoom(Room room) {
        try {
            dao.updateData(room);
        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
            return -1;
        }
        return 1;
    }

    @Override
    public Room query(String roomId) {
        Room room = new Room();
        room.setRoomId(roomId);

        try {
            return (Room) dao.query(room);
        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
            return null;
        }
    }

    @Override
    public ArrayList query(int page, int limit) {
        int start = (page * limit) - limit + 1; //每一页的起始位置

        if (start < 1)  //小于1的话会触发一个错误
            start = 1;  //但是理论上page和limit是由table表格生成的参数

        try {
            return dao.query(start, limit);
        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
            return null;
        }
    }

    @Override
    public int queryRoomNum() {

        try {
            return dao.queryDataNum();
        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
            return -1;
        }
    }

    @Override
    public int queryRepeat(String newName, String oldName) {
        Room room;

        try {
            room = dao.queryName(newName);
            if (room != null) {//表示存在同名项
                if (room.getRoomId().equals(oldName))
                    return 2;           //表示存在同名项，但是是与传递来的相同
                return 0;
            } else
                return 1;
        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
            return -1;
        }
    }

	@Override
	public ArrayList query(int page, int limit, String status) {
		// TODO Auto-generated method stub
		 int start = (page * limit) - limit + 1; //每一页的起始位置

	        if (start < 1)  //小于1的话会触发一个错误
	            start = 1;  //但是理论上page和limit是由table表格生成的参数

	        try {
	            return dao.query(start, limit,status);
	        } catch (SQLException e) {
	            System.out.println(e.getErrorCode() + e.getMessage());
	            return null;
	        }
	}

}
