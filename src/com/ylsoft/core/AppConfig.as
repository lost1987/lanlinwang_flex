package com.ylsoft.core
{
	import mx.collections.ArrayCollection;

	public class AppConfig
	{
		//public static const HOST:String = 'http://58.215.75.176';
		/*public static const HOST:String = 'http://192.168.20.228';
		public static const AMFURL : String = HOST+'/lanlinwang/gateway.php';
		public static const EXCEL_GATEWAY : String = HOST+'/lanlinwang/excel_gateway.php';
		public static const PROCESS_URL : String = HOST+'/lanlinwang/deamon/client.php';
		public static const INFO_URL : String = HOST+'/lanlinwang/flexhtml/phpinfo.php';
		public static const INFO_PWD:String = 'bdijltvwxzBCDEFGIJLMOQTVWXZ12357';*/
		
		public static var HOST:String = '';
		public static var AMFURL : String = '';
		public static var EXCEL_GATEWAY : String = '';
		public static var INFO_URL : String = '';
		public static var INFO_PWD:String = '';
		public static var PROCESS_URL : String = '';
		
		public static const MATERIAL:String = 'com/ylsoft/assets/images/';
		public static const CSVPATH:String = 'com/ylsoft/assets/csv/';
		public static const MODULEPATH:String = 'com/ylsoft/module/';
		public static const FORMADD:String = 'add';
		public static const FORMEDIT:String = 'edit';
		public static const PAGECOUNT:Number = 18;
		public static const USE_WAITING_IMAGE:Boolean = true;
		
		
		public static var admin:Object;//当前用户信息
		public static var formoperation:String;//当前表单是添加还是更新
		public static var formid:Number ;//如果请求是修改form那么 当前选中项的id值
		public static var buissnesser:ArrayCollection;
		public static var datelimit:int = 15;//综合查询时间的最大跨度 单位:天
		
		//权限
		public static var PERMISSIONS:ArrayCollection ;
		
		//EXCEL
		public static var module_key : String;
		public static var excel_name : String;
		
		//判断数据库引擎 以辨别该如何分页传值 关联到subpages组件
		public static const DBTYPE:String = 'mysql';
		//public static const DBTYPE:String = 'mssql';
		
	}
}