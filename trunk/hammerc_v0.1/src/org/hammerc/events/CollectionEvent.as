/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.events
{
	import flash.events.Event;
	
	/**
	 * <code>CollectionEvent</code> 类定义了列表项目改变时发送的事件.
	 * @see org.hammerc.collections.ArrayCollection
	 * @author wizardc
	 */
	public class CollectionEvent extends Event
	{
		/**
		 * 列表项目改变前的事件.
		 * <p>此事件具有以下属性:</p>
		 * <table class="innertable">
		 *   <tr><th>Property</th><th>Value</th></tr>
		 *   <tr><td><code>changeType</code></td><td>列表项目改变的类型.</td></tr>
		 *   <tr><td><code>startIndex</code></td><td>列表项目改变的起始索引.</td></tr>
		 *   <tr><td><code>endIndex</code></td><td>列表项目改变的结束索引.</td></tr>
		 *   <tr><td><code>items</code></td><td>列表项目改变的元素数组.</td></tr>
		 *   <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>cancelable</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>currentTarget</code></td><td>当前正在使用某个事件侦听器处理该事件的对象.</td></tr>
		 *   <tr><td><code>target</code></td><td>发送该事件的对象.</td></tr>
		 * </table>
		 * @eventType preItemChange
		 */
		public static const PRE_ITEM_CHANGE:String = "preItemChange";
		
		/**
		 * 列表项目改变后的事件.
		 * <p>此事件具有以下属性:</p>
		 * <table class="innertable">
		 *   <tr><th>Property</th><th>Value</th></tr>
		 *   <tr><td><code>changeType</code></td><td>列表项目改变的类型.</td></tr>
		 *   <tr><td><code>startIndex</code></td><td>列表项目改变的起始索引.</td></tr>
		 *   <tr><td><code>endIndex</code></td><td>列表项目改变的结束索引.</td></tr>
		 *   <tr><td><code>items</code></td><td>列表项目改变的元素数组.</td></tr>
		 *   <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>cancelable</code></td><td><code>false</code></td></tr>
		 *   <tr><td><code>currentTarget</code></td><td>当前正在使用某个事件侦听器处理该事件的对象.</td></tr>
		 *   <tr><td><code>target</code></td><td>发送该事件的对象.</td></tr>
		 * </table>
		 * @eventType itemChange
		 */
		public static const ITEM_CHANGE:String = "itemChange";
		
		private var _changeType:int;
		private var _startIndex:int;
		private var _endIndex:int;
		private var _items:*;
		
		/**
		 * 创建一个 <code>CollectionEvent</code> 对象.
		 * @param type 事件的类型.
		 * @param changeType 列表项目改变的类型.
		 * @param startIndex 列表项目改变的起始索引.
		 * @param endIndex 列表项目改变的结束索引.
		 * @param items 列表项目改变的元素数组.
		 */
		public function CollectionEvent(type:String, changeType:int, startIndex:int = -1, endIndex:int = -1, items:* = null)
		{
			super(type, false, false);
			_changeType = changeType;
			_startIndex = startIndex;
			_endIndex = endIndex;
			_items = items;
		}
		
		/**
		 * 获取列表项目改变的类型.
		 */
		public function get changeType():int
		{
			return _changeType;
		}
		
		/**
		 * 获取列表项目改变的起始索引.
		 */
		public function get startIndex():int
		{
			return _startIndex;
		}
		
		/**
		 * 获取列表项目改变的结束索引.
		 */
		public function get endIndex():int
		{
			return _endIndex;
		}
		
		/**
		 * 获取列表项目改变的元素数组.
		 */
		public function get items():*
		{
			return _items;
		}
		
		/**
		 * 创建本事件对象的副本, 并设置每个属性的值以匹配原始属性值.
		 * @return 其属性值与原始属性值匹配的新对象.
		 */
		override public function clone():Event
		{
			return new CollectionEvent(this.type, this.changeType, this.startIndex, this.endIndex, this.items);
		}
		
		/**
		 * 返回一个描述本对象的字符串.
		 * @return 一个字符串, 其中包含本对象的描述.
		 */
		override public function toString():String
		{
			return this.formatToString("CollectionEvent", "type", "bubbles", "cancelable", "changeType", "startIndex", "endIndex", "items");
		}
	}
}
