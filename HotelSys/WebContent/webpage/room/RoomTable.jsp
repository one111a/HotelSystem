<%@ page contentType="text/html;charset=UTF-8" %>
<html>

	<head>
		<meta charset="utf-8">
		<title>酒店管理系统</title>
		<link rel="stylesheet" href="../../js/layui/css/layui.css" media="all">
		<link rel="stylesheet" href="../../MAIN/component/font-awesome-4.7.0/css/font-awesome.min.css">
		<script src="../../js/layui/layui.js"></script>
		<script src="../../js/jquery.js"></script>
		<script src="../../js/global.js"></script>
		<script src="../../js/toExcel/xlsx.full.min.js"></script>
		<script type="text/javascript" src="../../js/toExcel/FileSaver.js"></script>
		<script type="text/javascript" src="../../js/toExcel/Export2Excel.js"></script>
		<style>
			body {
				margin: 10px;
			}
			
			.layui-elem-field legend {
				font-size: 14px;
			}
			
			.layui-field-title {
				margin: 25px 0 15px;
			}
		</style>
	</head>

	<body>
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
			<legend>
				<div>
					<div class="layui-inline">
						<div class="layui-input-inline">
							<input class="layui-input" id="inputSearch" placeholder="房间号">
						</div>
						<button class="layui-btn fa fa-search" id="searchButton"> 搜索</button>
					</div>
					<div class="layui-inline">
						<button class="layui-btn fa fa-refresh" id="refreshButton"> 刷新</button>
					</div>
					<div class="layui-inline">
						<button class="layui-btn fa fa-pencil-square-o " id="insertButton"> 新增</button>
					</div>
				</div>
			</legend>
		</fieldset>
		<div id="toxlsTable">
			<table id="tableID"></table>
		</div>
		<script type="text/html" id="barAuth">
			<a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
			<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
		</script>
		<script>
			layui.use(['util', 'layer', 'table'], function() {
				$(document).ready(function() {
					var table = layui.table,
						layer = layui.layer,
						util = layui.util;
					var countNum;
					var tableIns = table.render({
						elem: '#tableID',
						id: 'tableID',
						url: baseUrl + '/RoomServlet',
						cols: [
							[{
								field: 'roomId',
								title: '房间编号',
								sort: true,
								fixed: true,
                                width: 80
							}, {
								field: 'typeName',
								title: '房间类型',
								width: 150
							}, {
								field: 'floorId',
								title: '房间楼层'
							}, {
								field: 'ratedNum',
								title: '可住人数'
							}, {
								field: 'bedNum',
								title: '床位数'
							}, {
								field: 'isSplice',
								title: '是否可拼房'
							}, {
								field: 'roomDescription',
								title: '房间描述'
							}, {
								field: 'status',
								title: '房间状态'
							}, {
								field: 'remark',
								title: '房间备注'
							}
							, {
								field: 'right',
								title: '管理',
								align: 'center',
								toolbar: '#barAuth',
								width: 200
							}]
						],
						page: true,
						where: {
							make: 0
						},
						done: function(res, curr, count) {
							countNum = count;
						}
					});

					//监听工具条
					table.on('tool', function(obj) {
						var data = obj.data,
							layEvent = obj.event;
						var roomId = data.roomId;
						var typeName = data.typeName;
						var floorId = data.floorId;
						var ratedNum = data.ratedNum;
						var bedNum = data.bedNum;
						var isSplice = data.isSplice;
						var status = data.status;
						var roomDescription = data.roomDescription;
						var remark = data.remark;

						if(layEvent === 'detail') {
							layer.alert(
								'房间编号：' + roomId + '<br>房间类型：' + typeName + '<br>所属楼层：' + floorId +
								'<br>可住人数：' + ratedNum + '<br>床位数：' + bedNum + '<br>是否可拼房：' + isSplice
								+ '<br>状态：' + status + '<br>房间描述：' + roomDescription + '<br>房间备注：' + remark 
								, {
									skin: 'layui-layer-lan',
									closeBtn: 0,
									title: '您当前选择的房间类型信息',
									anim: 4,
									offset: '180px'
								});
						} else if(layEvent === 'del') {
							layer.confirm('您确定要删除该条数据吗？', {
								offset: '180px',
								btn: ['是滴', '手滑']
							}, function() {
								table.reload('tableID', {
									where: {
										make: 4,
										roomId: roomId
									}
								});
								layer.msg('删除结果如下', {
									offset: '250px',
									icon: 1
								});
							}, function() {
								layer.msg('删除操作已取消', {
									offset: '250px'
								});
							});
						} else if(layEvent === 'edit') {
							//编辑
							layer.open({
								title: "编辑",
								btn: ['关闭'],
								yes: function(index) {
									tableIns.reload({
										where: {
											make: 0
										}
									});
									layer.close(index); //关闭弹窗
								},
								type: 2,
								area: ['780px', '680px'],
								fixed: false,
								maxmin: true,
								content: '/HotelSys/webpage/room/updateRome.jsp?roomId='+roomId,
								cancel: function() {
									tableIns.reload({
										where: {
											make: 0
										}
									});
								}
							});
						}
					});

					//搜索
					$('#searchButton').click(function() {
						var inputTxt = $('#inputSearch').val();
						if(inputTxt === "")
							layer.msg('您必须输入值', {
								offset: '250px'
							});
						else if(inputTxt.length > 10)
							layer.msg('您所输入的值长度不合法', {
								offset: '250px'
							});
						else {
							layer.msg('搜索结果', {
								offset: '250px'
							});
							table.reload('tableID', {
								where: {
									make: 3,
									roomId: inputTxt
								}
							})
						}
					});

					//刷新
					$('#refreshButton').click(function() {
						// 简述此处存在的BUG 删除操作触发外键依赖后，出500异常
						// 通过msg回传参数，尔后执行刷新操作时，框架本身死掉
						// 即往后端传入的分页参数固定为1，表格的重载刷新失效
						// 暂时只发现删除引起的异常，先通过强制刷新解决此处异常
						// tableIns.reload({
						// 	where: {
						// 		make: 0,
						// 		page: 1
						// 	}
						// });
						location.reload();
					});

					//新增
					$('#insertButton').click(function() {
						layer.open({
							title: "新增",
							btn: ['关闭'],
							yes: function(index) {
								tableIns.reload({
									where: {
										make: 0
									}
								});
								layer.close(index); //关闭弹窗
							},
							type: 2,
							area: ['780px', '680px'],
							fixed: false,
							maxmin: true,
							content: '/HotelSys/webpage/room/insertRome.jsp',
							cancel: function() {
								tableIns.reload({
									where: {
										make: 0
									}
								});
							}
						});
					});

					//导出
					$('#toXlsButton').click(function() {
						location.href = baseUrl + '/RoomInfoExcelServlet';
						layer.alert('Excel文件生成完成！', {
							title: '成功',
							icon: 6,
							anim: 1,
							offset: '250px'
						});
					});

					//回到顶端
					util.fixbar({
						showHeight: 2,
						click: function(type) {
							console.log(type);
						}
					});
				});
			});
		</script>

	</body>

</html>