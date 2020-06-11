package com.inks.hb.room.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.inks.hb.room.service.RoomService;
import com.inks.hb.room.service.RoomServiceImpl;

@WebServlet(name = "selectRomeServlet", value = "/selectRomeServlet")
public class selectRomeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 设置编码
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        // 响应输出流
        PrintWriter out = response.getWriter();

        RoomService service = new RoomServiceImpl();


        ArrayList list = service.query(1, service.queryRoomNum(),"可入住");
        //转换为json字符串格式
        Gson gson = new Gson();
        out.print(gson.toJson(list));

    }
}
