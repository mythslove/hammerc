/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager.dragClasses
{
	/**
	 * <code>DragData</code> 类包含被拖动的数据.
	 * @author wizardc
	 */
	public class DragData
	{
		/**
		 * 记录数据对象.
		 */
		protected var _dataMap:Object;
		
		/**
		 * 创建一个 <code>DragData</code> 对象.
		 */
		public function DragData()
		{
			_dataMap = new Object();
		}
		
		/**
		 * 获取所有数据名称的列表.
		 */
		public function get dataNameList():Vector.<String>
		{
			var list:Vector.<String> = new Vector.<String>();
			for(var key:String in _dataMap)
			{
				list.push(key);
			}
			return list;
		}
		
		/**
		 * 添加一条数据.
		 * @param name 数据名称.
		 * @param data 数据内容.
		 */
		public function addData(name:String, data:*):void
		{
			_dataMap[name] = data;
		}
		
		/**
		 * 判断是否存在数据.
		 * @param name 数据名称.
		 * @return 指定名称的数据是否存在.
		 */
		public function hasData(name:String):Boolean
		{
			return _dataMap.hasOwnProperty(name);
		}
		
		/**
		 * 获取指定名称的数据.
		 * @param name 数据名称.
		 * @return 指定名称的数据.
		 */
		public function getData(name:String):*
		{
			return _dataMap[name];
		}
		
		/**
		 * 清除指定名称的数据.
		 * @param name 数据名称.
		 * @return 清除的数据.
		 */
		public function removeData(name:String):*
		{
			var data:* = _dataMap[name];
			delete _dataMap[name];
			return data;
		}
		
		/**
		 * 清空所有数据.
		 */
		public function removeAll():void
		{
			_dataMap = new Object();
		}
	}
}
