package com.ylsoft.common
{
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.effects.Blur;
	import mx.effects.Move;
	import mx.effects.Resize;
	import mx.effects.easing.Elastic;
	import mx.managers.PopUpManager;
	
	
	public class Toolkit
	{

		public static function blankClear(str:String):String{
			  return str.replace(/\s+/g,'');
		}
		
		//判断集合中某个对象是否存在
		public static function isObjectExsit(obj:Object,ac:ArrayCollection):Boolean{
			for each(var o:Object in ac){
				if(o == obj){
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 深度复制
		 * */
		public static function clone(source:Object):*
		{
			var myBA:ByteArray = new ByteArray();
			myBA.writeObject(source);
			myBA.position = 0;
			return(myBA.readObject());
		}
		
		/**
		 *判断对象是否存在数组中 
		 **/
		public static function in_array(obj:Object,list:Array):Boolean{
			for each(var o : Object in list){
				if(obj == o){
					return true;
					break;
				}
			}
			return false;
		}
		
		/**
		 *通过对象属性 获取集合中的对象 
		 ***/
		public static function getObjectFromCollectionByProperty(property:String,value:Object,collection:ArrayCollection):Object{
				for each(var item:Object in collection){
					if(item.hasOwnProperty(property)){
						if(item[property] == value)
						return item;
					}
				}
				return null;
		}
		
	}
}