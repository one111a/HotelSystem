package com.inks.hb.room.service;

import java.util.ArrayList;

import com.inks.hb.room.pojo.Room;

/**
 * 数据异常在本层解决
 * 但凡出现SQL方面异常均返回-1
 */
public interface RoomService {

    //增添
    int insertRoom(Room room);

    //删除
    int deleteRoom(String roomId);

    //更新
    int updateRoom(Room room);

    //查询单条
    Room query(String roomId);

    //查询多条
    ArrayList query(int page, int limit);
    
  //查询多条可用房间
    ArrayList query(int page, int limit,String status);

    //查询长度
    int queryRoomNum();

    /**
     * 查重函数
     *
     * @param newName oldName 房间类型名称
     * @return 0:已经存在 1：未存在 2：与自身相同
     */
    int queryRepeat(String newName, String oldName);
}
