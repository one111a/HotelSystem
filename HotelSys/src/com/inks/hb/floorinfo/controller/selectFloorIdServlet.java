package com.inks.hb.floorinfo.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.inks.hb.floorinfo.service.FloorInfoService;
import com.inks.hb.floorinfo.service.FloorInfoServiceImpl;

@WebServlet(name = "selectFloorIdServlet", value = "/selectFloorIdServlet")
public class selectFloorIdServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 设置编码
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        // 响应输出流
        PrintWriter out = response.getWriter();

        FloorInfoService service = new FloorInfoServiceImpl();


        ArrayList list = service.query(1, service.queryFloorInfoNum());
        //转换为json字符串格式
        Gson gson = new Gson();
        out.print(gson.toJson(list));

    }
}
