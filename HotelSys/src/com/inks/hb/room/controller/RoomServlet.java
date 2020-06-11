package com.inks.hb.room.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.inks.hb.common.PojotoGson;
import com.inks.hb.room.pojo.Room;
import com.inks.hb.room.service.RoomService;
import com.inks.hb.room.service.RoomServiceImpl;
import com.inks.hb.roomtype.pojo.RoomType;

/**
 * 与表格相关的全部操作
 * 状态标志： make 0重载 1新增 2修改 3搜索 4删除
 */
@WebServlet(name = "RoomServlet", value = "/RoomServlet")
public class RoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();

        int page = Integer.parseInt(request.getParameter("page")); // 当前页码
        int limit = Integer.parseInt(request.getParameter("limit")); // 每页的数据量
        int make = Integer.parseInt(request.getParameter("make")); //状态标志

        // 调用service
        RoomService service = new RoomServiceImpl();

        // 默认输出信息
        String code = "0"; //状态码
        String msg = "数据查询正常"; //状态信息
        String count = ""; //数据总数
        ArrayList list = new ArrayList<>(); //数据内容
        ArrayList<Room> searchList = new ArrayList<Room>(); //数据内容

        //单个全局属性
        String roomId = ""; //房间编号
        String price; //价格
        String splicPrice; //拼房价格
        int exceedance; //可超预定数
        String isSplice; //是否可拼房
        Room room = null;

        //获取对应状态属性
        if (make == 1 || make == 2) { //1和2这部分完全是相同的
        	roomId = request.getParameter("roomId");
            roomId = request.getParameter("typeName");
            price = request.getParameter("price");
            splicPrice = request.getParameter("splicPrice");
            exceedance = Integer.parseInt(request.getParameter("exceedance"));
            isSplice = request.getParameter("isSplice");
            //room = new RoomType(typeId, roomId, price, splicPrice, exceedance, isSplice);
        } else if (make == 4) {
        	roomId = request.getParameter("roomId");
        } else if (make == 3) {
            roomId = request.getParameter("roomId");
        }

        // 状态标志 make 0重载 1新增 2修改 3搜索 4删除
        switch (make) {
            case 1:
//                if (service.insertRoomType(roomType) == -1) {
//                    msg = "插入异常";
//                    code = "-1";
//                }
                break;
            case 2:
//                if (service.updateRoomType(roomType) == -1) {
//                    msg = "修改异常";
//                    code = "-1";
//                }
                break;
            case 3:
                list = service.query(1, service.queryRoomNum());
                searchList.clear();
                for (Object temp : list) {
                    room = (Room) temp; //用contains模糊查询 机智啊，这样连mysql的like语句都不用写   --2017.12.7 改
                    if (room.getRoomId().contains(roomId)) {
                        searchList.add(room);
                    }
                }
                break;
            case 4:
                if (service.deleteRoom(roomId) == -1) {
                    msg = "删除失败";
                    code = "-1";
                }
                break;
        }

        if (make != 3) {
            list = service.query(page, limit);
            count = String.valueOf(service.queryRoomNum());
        } else { //这部分算是对3搜索的特殊处理，放这儿和放case里一样的。
            int size = searchList.size();
            if (size == 0) {
                msg = "查无此项";
                code = "-1";
            } else {
                list = searchList;
                count = Integer.toString(size);
            }
        }

        PojotoGson pojotoGson = new PojotoGson(code, msg, count, list);
        Gson gson = new Gson();
        out.print(gson.toJson(pojotoGson));
    }
}
