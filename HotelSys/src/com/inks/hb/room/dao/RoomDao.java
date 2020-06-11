package com.inks.hb.room.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.inks.hb.common.CommonDao;
import com.inks.hb.common.DBUtil;
import com.inks.hb.room.pojo.Room;
import com.inks.hb.roomtype.pojo.RoomType;

/**
 * 房间类型 DAO
 * 提供独立函数：public RoomType queryName(String typeName) throws SQLException
 * 根据类型名称进行查询
 */
public class RoomDao implements CommonDao {

    @Override
    public void insertData(Object o) throws SQLException {

        Room room = (Room) o;

        Connection conn = DBUtil.getConnection();

        String sql = "INSERT INTO roominfo VALUES (?,?,?,?,?,?,?,?,?,?)";

        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, room.getRoomId());
        pstmt.setString(2, room.getTypeId());
        pstmt.setString(3, room.getTypeName());
        pstmt.setInt(4, room.getFloorId());
        pstmt.setInt(5, room.getRatedNum());
        pstmt.setInt(6, room.getBedNum());
        pstmt.setString(7, room.getRoomDescription());
        pstmt.setString(8, room.getRemark());
        pstmt.setString(9, room.getStatus());
        pstmt.setString(10, room.getIsSplice());

        pstmt.executeUpdate();

        pstmt.close();
    }

    @Override
    public void deleteData(Object o) throws SQLException {
        Room room = (Room) o;

        Connection conn = DBUtil.getConnection();

        String sql = "DELETE FROM roominfo WHERE roomId = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, room.getRoomId());

        pstmt.executeUpdate();
        pstmt.close();
    }

    @Override
    public void updateData(Object o) throws SQLException {
        Room room = (Room) o;

        Connection conn = DBUtil.getConnection();

        String sql = "UPDATE roominfo SET typeId = ? ,typeName = ? ,floorId = ? ,ratedNum = ? ,bedNum = ? ,roomDescription = ? ,remark = ? ,status = ? ,isSplice = ? WHERE roomId = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, room.getTypeId());
        pstmt.setString(2, room.getTypeName());
        pstmt.setInt(3, room.getFloorId());
        pstmt.setInt(4, room.getRatedNum());
        pstmt.setInt(5, room.getBedNum());
        pstmt.setString(6, room.getRoomDescription());
        pstmt.setString(7, room.getRemark());
        pstmt.setString(8, room.getStatus());
        pstmt.setString(9, room.getIsSplice());
        pstmt.setString(10, room.getRoomId());

        pstmt.executeUpdate();
        pstmt.close();
    }

    @Override
    public int queryDataNum() throws SQLException {

        Connection conn = DBUtil.getConnection();

        String sql = "select count(*) from roominfo;";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        int num;
        if (rs.next()) num = rs.getInt("count(*)");
        else num = 0;

        rs.close();
        pstmt.close();

        return num;
    }

    @Override
    public ArrayList query(int start, int length) throws SQLException {

        Connection conn = DBUtil.getConnection();

        String sql = "select * from roominfo limit ?, ?;";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, (start - 1));   //
        pstmt.setInt(2, length);
        ResultSet rs = pstmt.executeQuery();

        ArrayList<Room> list = new ArrayList<Room>();

        while (rs.next()) {
            Room room = new Room();
            room.setBedNum(rs.getInt("bedNum"));
            room.setFloorId(rs.getInt("floorId"));
            room.setIsSplice(rs.getString("isSplice"));
            room.setRatedNum(rs.getInt("ratedNum"));
            room.setRemark(rs.getString("remark"));
            room.setRoomDescription(rs.getString("roomDescription"));
            room.setRoomId(rs.getString("roomId"));
            room.setStatus(rs.getString("status"));
            room.setTypeId(rs.getString("typeId"));
            room.setTypeName(rs.getString("typeName"));
            list.add(room);
        }

        rs.close();
        pstmt.close();

        return list;
    }

    @Override
    public Object query(Object o) throws SQLException {
        Room roomQuery = (Room) o;

        Connection conn = DBUtil.getConnection();

        String sql = "SELECT * FROM roominfo WHERE roomId = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, roomQuery.getRoomId());
        ResultSet rs = pstmt.executeQuery();

        Room room = null;
        while (rs.next()) {
        	room = new Room();
            room.setBedNum(rs.getInt("bedNum"));
            room.setFloorId(rs.getInt("floorId"));
            room.setIsSplice(rs.getString("isSplice"));
            room.setRatedNum(rs.getInt("ratedNum"));
            room.setRemark(rs.getString("remark"));
            room.setRoomDescription(rs.getString("roomDescription"));
            room.setRoomId(rs.getString("roomId"));
            room.setStatus(rs.getString("status"));
            room.setTypeId(rs.getString("typeId"));
            room.setTypeName(rs.getString("typeName"));
        }

        if (room == null) {
            room = new Room();
        }
        rs.close();
        pstmt.close();

        return room;
    }

    /**
     * 根据房间号进行查询
     *
     * @param typeName 包装成typeName的待查询对象
     * @return 包装成roomType的查询结果
     * @throws SQLException 数据库
     */
    public Room queryName(String roomId) throws SQLException {

        Connection conn = DBUtil.getConnection();

        String sql = "SELECT * FROM roominfo WHERE roomId = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, roomId);
        ResultSet rs = pstmt.executeQuery();

        Room room = null;
        while (rs.next()) {
        	room = new Room();
            room.setBedNum(rs.getInt("bedNum"));
            room.setFloorId(rs.getInt("floorId"));
            room.setIsSplice(rs.getString("isSplice"));
            room.setRatedNum(rs.getInt("ratedNum"));
            room.setRemark(rs.getString("remark"));
            room.setRoomDescription(rs.getString("roomDescription"));
            room.setRoomId(rs.getString("roomId"));
            room.setStatus(rs.getString("status"));
            room.setTypeId(rs.getString("typeId"));
            room.setTypeName(rs.getString("typeName"));
        }

       
        rs.close();
        pstmt.close();

        return room;
    }
    
    public ArrayList query(int start, int length,String status) throws SQLException {

        Connection conn = DBUtil.getConnection();

        String sql = "select * from roominfo where status = ? limit ?, ?;";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, status);
        pstmt.setInt(2, (start - 1));   //
        pstmt.setInt(3, length);
        ResultSet rs = pstmt.executeQuery();

        ArrayList<Room> list = new ArrayList<Room>();

        while (rs.next()) {
            Room room = new Room();
            room.setBedNum(rs.getInt("bedNum"));
            room.setFloorId(rs.getInt("floorId"));
            room.setIsSplice(rs.getString("isSplice"));
            room.setRatedNum(rs.getInt("ratedNum"));
            room.setRemark(rs.getString("remark"));
            room.setRoomDescription(rs.getString("roomDescription"));
            room.setRoomId(rs.getString("roomId"));
            room.setStatus(rs.getString("status"));
            room.setTypeId(rs.getString("typeId"));
            room.setTypeName(rs.getString("typeName"));
            list.add(room);
        }

        rs.close();
        pstmt.close();

        return list;
    }
}
