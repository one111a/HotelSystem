package com.inks.hb.billinfo.controller;

import java.util.ArrayList;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inks.hb.billinfo.pojo.BillInfo;
import com.inks.hb.billinfo.service.BillInfoService;
import com.inks.hb.billinfo.service.BillInfoServiceImpl;
import com.inks.hb.common.ExportExcel;

@WebServlet(name = "BillInfoExcelServlet", value = "/BillInfoExcelServlet")
public class BillInfoExcelServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) {

        BillInfoService service = new BillInfoServiceImpl();

        ArrayList<BillInfo> infoArrayList = service.query(1, service.queryBillInfoNum());


        String[] headers = {"账单IDS","入住单号", "账单金额", "账单时间", "备注"};
        String fileName = "入住信息";

        ExportExcel<BillInfo> ee = new ExportExcel<BillInfo>();
        ee.exportExcel(headers, infoArrayList, fileName, response);
    }
}
