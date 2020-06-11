package com.inks.hb.orderinfo.controller;

import java.util.ArrayList;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inks.hb.common.ExportExcel;
import com.inks.hb.orderinfo.pojo.CheckInfo;
import com.inks.hb.orderinfo.service.CheckInfoService;
import com.inks.hb.orderinfo.service.CheckInfoServiceImpl;
import com.inks.hb.roomtype.service.RoomTypeService;
import com.inks.hb.roomtype.service.RoomTypeServiceImpl;

@WebServlet(name = "CheckInfoExcelServlet", value = "/CheckInfoExcelServlet")
public class CheckInfoExcelServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {

        CheckInfoService service = new CheckInfoServiceImpl();
        RoomTypeService roomTypeService = new RoomTypeServiceImpl();

        ArrayList<CheckInfo> infoArrayList = service.query(1, service.queryCheckInfoNum());



        for (CheckInfo checkInfo : infoArrayList) { //转换成前端界面可接收的类型 主要是转 房间类型 和操作员
           checkInfo.setTypeId(roomTypeService.query(checkInfo.getTypeId()).getTypeName());
        }

        String[] headers = {"入住单号","预订单号", "入住人", "联系电话", "身份证", "抵店时间", "离店时间", "房间类型", "房间编号", "入住人数", "客房价格", "入住价格", "折扣", "折扣原因", "是否加床", "加床价格", "预收款","应收款","结账收款", "单据状态","结账时间","是否结账", "备注", "操作员"};
        String fileName = "入住信息";

        ExportExcel<CheckInfo> ee = new ExportExcel<CheckInfo>();
        ee.exportExcel(headers, infoArrayList, fileName, response);
    }
}
