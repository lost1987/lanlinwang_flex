package com.ylsoft.event
{
	import flash.events.Event;
	
	public class AppEvent extends Event
	{
		
		public static const AMF_GLOABAL_COMPLETE : String = 'amf_gloabal_complete';
		
		public static const AMF_GLOABAL_FAULT : String = 'amf_gloable_fault';
		
		public static const UIREMOTEOBJECT_SEND:String  = 'uiremoteobject_send';
		
		public static const UIREMOTEOBJECT_FINISH:String = 'uiremoteobject_finish';
		
		public static const BUISSNESSER_CHOOSE_COMPLETE : String = 'buissnesser_choose_complete';
		
		public static const CHKDATAGRID_CHECKED_CHANGE :String = 'chkdatagrid_checked_change';
		
		public static const EXCEL_EXPORT_READY : String = 'excel_export_ready';
		
		public static const COMPONENT_EXPORT_IMAGE_READY : String = 'component_export_image_ready';
		
		public function AppEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}