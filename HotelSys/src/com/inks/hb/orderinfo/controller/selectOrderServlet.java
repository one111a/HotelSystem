package com.inks.hb.orderinfo.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.inks.hb.orderinfo.pojo.OrderInfo;
import com.inks.hb.orderinfo.service.OrderInfoService;
import com.inks.hb.orderinfo.service.OrderInfoServiceImpl;

@WebServlet(name = "selectOrderServlet", value = "/selectOrderServlet")
public class selectOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 设置编码
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        // 响应输出流
        PrintWriter out = response.getWriter();

        OrderInfoService service = new OrderInfoServiceImpl();


        ArrayList<OrderInfo> list = service.query(1, service.queryOrderInfoNum());
        
        List<OrderInfo> retInfos = new ArrayList<OrderInfo>();
        for(OrderInfo oi:list){
        	if("预定".equals(oi.getOrderState())){
        		retInfos.add(oi);
        	}
        }
        //转换为json字符串格式
        Gson gson = new Gson();
        out.print(gson.toJson(retInfos));

    }
}
