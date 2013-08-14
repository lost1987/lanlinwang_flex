package com.ylsoft.chart
{
	import mx.charts.HitData;
	import mx.charts.chartClasses.CartesianTransform;
	import mx.charts.chartClasses.NumericAxis;
	import mx.charts.series.LineSeries;
	import mx.charts.series.items.LineSeriesItem;
	import mx.controls.Alert;
	import mx.graphics.IStroke;
	import mx.graphics.LinearGradientStroke;
	import mx.graphics.SolidColorStroke;
	
	/**
	 * 
	 * @author lost
	 * 为了Y轴显示同一Y坐标轴上的多个series数据
	 */
	public class ChartLineSeries extends LineSeries
	{
		private var _disabled:Boolean = false;//禁用/启用多seriesY轴同步
		
		
		
		public function get disabled():Boolean
		{
			return _disabled;
		}

		public function set disabled(value:Boolean):void
		{
			_disabled = value;
		}

		/**
		 * 
		 * @param data
		 * @param index
		 * 
		 */
		public function addDataTip(data:Object, index:int):void
		{
			
			if(this.chart.showDataTips){
				var item:LineSeriesItem = new LineSeriesItem(this, data, index);
				var arr:Array = new Array();
				arr.push(item);
				this.dataTipItems = arr;
			}
		}
		
		public function removeDataTip():void{
			this.dataTipItems = [];
		}
		
		override public function findDataPoints(x:Number,y:Number,sensitivity:Number):Array
		{
			// esg, 8/7/06: if your mouse is over a series when it gets added and displayed for the first time, this can get called
			// before updateData, and before and render data is constructed. The right long term fix is to make sure a stubbed out 
			// render data is _always_ present, but that's a little disruptive right now.
			if(this.disabled) return [];
			
			//     var showDatatip:Boolean = this.getSerie().datatip==null||this.getSerie().datatip=="yes"||this.getSerie().datatip=="event";
			if (interactive == false || !renderData )
				return [];
			
			var pr:Number = getStyle("radius");
			var minDist2:Number  = pr + sensitivity;
			
			minDist2 *= minDist2;
			var minItem:LineSeriesItem = null;     
			var pr2:Number = pr * pr;
			// validating fliteredcache existance to fix the null pointer exception issue
			var len:int;
			if(renderData!=null && renderData.filteredCache!=null)
				len = renderData.filteredCache.length;
			
			if (len == 0)
				return [];
			
			if(sortOnXField == true)
			{            
				var low:Number = 0;
				var high:Number = len;
				var cur:Number = Math.floor((low+high)/2);
				
				var bFirstIsNaN:Boolean = isNaN(renderData.filteredCache[0]);
				
				while (true)
				{
					var v:LineSeriesItem = renderData.filteredCache[cur];
					//xfilter and yfilter varibles changed to xNumber and ynumber to fix the data tip issue when setfilterdata to false          
					if (!isNaN(v.yNumber) && !isNaN(v.xNumber))
					{
						var dist:Number = (v.x  - x)*(v.x  - x);
						if (dist <= minDist2)
						{
							minDist2 = dist;
							minItem = v;                
						}
					}
					// if there are NaNs in this array, it's for one of a couple of reasons:
					// 1) there were NaNs in the data, which menas an xField was provided, which means they got sorted to the end
					// 2) some values got filtered out, in which case we can (sort of) safely assumed that the got filtered from one side, the other, or the entire thing.
					// we'll assume that an axis hasn't filtered a middle portion of the array.
					// since we can assume that any NaNs are at the beginning or the end, we'll rely on that in our binary search.  If there was a NaN in the first slot,
					// then we'll assume it's safe to move up the array if we encounter a NaN.  It's possible the entire array is NaN, but then nothing will match, so that's ok.
					if (v.x < x || (isNaN(v.x) && bFirstIsNaN))
					{
						low = cur;
						cur = Math.floor((low + high)/2);
						if (cur == low)
							break;
					}
					else
					{
						high = cur;
						cur = Math.floor((low + high)/2);
						if (cur == high)
							break;
					}
				}
			}
			else
			{
				var i:uint;
				for (i=0; i<len; i++)
				{
					v = renderData.filteredCache[i];          
					if (!isNaN(v.yFilter) && !isNaN(v.xFilter))
					{
						dist = (v.x  - x)*(v.x  - x) + (v.y - y)*(v.y -y);
						if (dist <= minDist2)
						{
							minDist2 = dist;
							minItem = v;               
						}
					}
				}
			}
			
			if (minItem)
			{
				var hd:HitData = new HitData(createDataID(minItem.index),Math.sqrt(minDist2),minItem.x,minItem.y,minItem);
				
				var istroke:IStroke = getStyle("lineStroke");
				if (istroke is SolidColorStroke)
					hd.contextColor = SolidColorStroke(istroke).color;
				else if (istroke is LinearGradientStroke)
				{
					var gb:LinearGradientStroke = LinearGradientStroke(istroke);
					if (gb.entries.length > 0)
						hd.contextColor = gb.entries[0].color;
				}
				hd.dataTipFunction = formatDataTip;
				return [ hd ];
			}
			
			return [];
		}
		
	
		/**
		 *  @private
		 */
		private function formatDataTip(hd:HitData):String
		{
			var dt:String = "";
			
			var n:String = displayName;
			if (n && n != "")
				dt += "<b>" + n + "</b><BR/>";
			
			var xName:String = dataTransform.getAxis(CartesianTransform.HORIZONTAL_AXIS).displayName;
			if (xName != "")
				dt += "<i>" + xName+ ":</i> ";
			dt += dataTransform.getAxis(CartesianTransform.HORIZONTAL_AXIS).formatForScreen(
				LineSeriesItem(hd.chartItem).xValue) + "\n";
			
			var yName:String = dataTransform.getAxis(CartesianTransform.VERTICAL_AXIS).displayName;
			if (yName != "")
				dt += "<i>" + yName + ":</i> ";
			dt += dataTransform.getAxis(CartesianTransform.VERTICAL_AXIS).formatForScreen(
				LineSeriesItem(hd.chartItem).yValue) + "\n";
			
			return dt;
		}
	}
}