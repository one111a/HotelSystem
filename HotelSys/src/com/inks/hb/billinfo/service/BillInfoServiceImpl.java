package com.inks.hb.billinfo.service;

import java.sql.SQLException;
import java.util.ArrayList;

import com.inks.hb.billinfo.dao.BillInfoDao;
import com.inks.hb.billinfo.pojo.BillInfo;

public class BillInfoServiceImpl implements BillInfoService {

    private BillInfoDao dao = new BillInfoDao();

    @Override
    public int insertBillInfo(BillInfo billInfo) {

        try {
        	dao.insertData(billInfo);
            
        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
            return -1;
        }
        return 1;
    }

    @Override
    public int deleteBillInfo(int billId) {
        BillInfo billInfo = new BillInfo();
        billInfo.setBillId(billId);

        try {
            dao.deleteData(billInfo);
        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
            return -1;
        }
        return 1;
    }

    @Override
    public int updateBillInfo(BillInfo billInfo) {
        try {
            dao.updateData(billInfo);
        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
            e.printStackTrace();
            return -1;
        }
        return 1;
    }

    @Override
    public BillInfo query(int billId) {
        BillInfo billInfo = new BillInfo();
        billInfo.setBillId(billId);

        try {
            return (BillInfo) dao.query(billInfo);
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
    public int queryBillInfoNum() {
        try {
            return dao.queryDataNum();
        } catch (SQLException e) {
            System.out.println(e.getErrorCode() + e.getMessage());
            return -1;
        }
    }

    

   

}
