package com.ylsoft.pri
{
	import com.shortybmc.data.parser.CSV;
	import com.ylsoft.core.AppConfig;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;

	public class StaticItems
	{
		private var csv:CSV;
		private static var sitems:StaticItems;
		private static var items:ArrayCollection;
		public var sourceUIComponet:UIComponent;
		
		public function StaticItems(cls:InnerClass)
		{
		}
		
		public static function instance():StaticItems{
			if(sitems == null){
				sitems = new StaticItems(new InnerClass);
			}
			
			return sitems;
		}
		
		public function staticItems():ArrayCollection{
				if(items == null){
					csv = new CSV(new URLRequest(AppConfig.CSVPATH+'item.csv'));
					csv.addEventListener(Event.COMPLETE,completehandler);
				}	
			     return items;
		}
		
		private function completehandler(evt:Event):void{
				items = new ArrayCollection(csv.data as Array);
				if(this.sourceUIComponet!=null)
					sourceUIComponet.dispatchEvent(new Event("ITEM_LIST_COMPLETE"));
		}
		
	}
}
class InnerClass{}



