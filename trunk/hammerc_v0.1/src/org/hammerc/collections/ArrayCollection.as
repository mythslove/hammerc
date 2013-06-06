/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.collections
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.hammerc.events.CollectionEvent;
	
	/**
	 * @eventType org.hammerc.events.CollectionEvent.PRE_ITEM_CHANGE
	 */
	[Event(name="preItemChange", type="org.hammerc.events.CollectionEvent")]
	
	/**
	 * @eventType org.hammerc.events.CollectionEvent.ITEM_CHANGE
	 */
	[Event(name="itemChange", type="org.hammerc.events.CollectionEvent")]
	
	/**
	 * <code>ArrayCollection</code> 类提供修改数组内部元素时发出相应的修改通知的功能并支持序列化.
	 * @author wizardc
	 */
	public class ArrayCollection extends ArrayList implements ICollection
	{
		/**
		 * 实现发送和侦听事件的对象.
		 */
		protected var _eventDispatcher:EventDispatcher;
		
		/**
		 * 创建一个 <code>ArrayCollection</code> 对象.
		 * @param array 指定初始内容.
		 */
		public function ArrayCollection(array:Array = null)
		{
			super(array);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addItem(item:*):int
		{
			this.dispatchEvent(new CollectionEvent(CollectionEvent.PRE_ITEM_CHANGE, CollectionType.ADD, this.size(), this.size(), item));
			var size:int = super.addItem(item);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.ITEM_CHANGE, CollectionType.ADD, this.size() - 1, this.size() - 1, item));
			return size;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addItemAt(item:*, index:int):int
		{
			this.dispatchEvent(new CollectionEvent(CollectionEvent.PRE_ITEM_CHANGE, CollectionType.ADD, index, index, item));
			var size:int = super.addItemAt(item, index);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.ITEM_CHANGE, CollectionType.ADD, index, index, item));
			return size;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addAll(list:IList):int
		{
			if(list == null)
			{
				return this.size();
			}
			this.dispatchEvent(new CollectionEvent(CollectionEvent.PRE_ITEM_CHANGE, CollectionType.ADD, this.size(), this.size() + list.size() - 1, list.toArray()));
			var size:int = super.addAll(list);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.ITEM_CHANGE, CollectionType.ADD, this.size(), this.size() + list.size() - 1, list.toArray()));
			return size;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addAllAt(list:IList, index:int):int
		{
			if(list == null)
			{
				return this.size();
			}
			if(index < 0 || index >= this.size())
			{
				index = this.size();
			}
			this.dispatchEvent(new CollectionEvent(CollectionEvent.PRE_ITEM_CHANGE, CollectionType.ADD, index, index + list.size() - 1, list.toArray()));
			var size:int = super.addAllAt(list, index);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.ITEM_CHANGE, CollectionType.ADD, index, index + list.size() - 1, list.toArray()));
			return size;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setItemAt(item:*, index:int):*
		{
			if(index < 0 || index >= this.size())
			{
				return null;
			}
			this.dispatchEvent(new CollectionEvent(CollectionEvent.PRE_ITEM_CHANGE, CollectionType.REPLACE, index, index, item));
			var old:* = super.setItemAt(item, index);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.ITEM_CHANGE, CollectionType.REPLACE, index, index, item));
			return old;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeItem(item:*):*
		{
			var index:int = this.indexOf(item);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.PRE_ITEM_CHANGE, CollectionType.REMOVE, index, index, item));
			var temp:* = super.removeItem(item);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.ITEM_CHANGE, CollectionType.REMOVE, index, index, item));
			return temp;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeItemAt(index:int):*
		{
			if(index < 0 || index >= this.size())
			{
				return null;
			}
			var item:* = this.getItemAt(index);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.PRE_ITEM_CHANGE, CollectionType.REMOVE, index, index, item));
			var temp:* = super.removeItemAt(index);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.ITEM_CHANGE, CollectionType.REMOVE, index, index, item));
			return temp;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAll(list:IList):Array
		{
			this.dispatchEvent(new CollectionEvent(CollectionEvent.PRE_ITEM_CHANGE, CollectionType.REMOVE));
			var temp:Array = super.removeAll(list);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.ITEM_CHANGE, CollectionType.REMOVE, -1, -1, temp));
			return temp;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function retainAll(list:IList):Array
		{
			this.dispatchEvent(new CollectionEvent(CollectionEvent.PRE_ITEM_CHANGE, CollectionType.REMOVE));
			var temp:Array = super.retainAll(list);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.ITEM_CHANGE, CollectionType.REMOVE, -1, -1, temp));
			return temp;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function sort(...args):Array
		{
			this.dispatchEvent(new CollectionEvent(CollectionEvent.PRE_ITEM_CHANGE, CollectionType.SORT, 0, this.size() - 1, this.toArray()));
			var temp:Array = super.sort.apply(null, args);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.ITEM_CHANGE, CollectionType.SORT, 0, this.size() - 1, this.toArray()));
			return temp;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function sortOn(fieldName:Object, options:Object = null):Array
		{
			this.dispatchEvent(new CollectionEvent(CollectionEvent.PRE_ITEM_CHANGE, CollectionType.SORT, 0, this.size() - 1, this.toArray()));
			var temp:Array = super.sortOn(fieldName, options);
			this.dispatchEvent(new CollectionEvent(CollectionEvent.ITEM_CHANGE, CollectionType.SORT, 0, this.size() - 1, this.toArray()));
			return temp;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clear():void
		{
			var temp:Array = this.toArray();
			this.dispatchEvent(new CollectionEvent(CollectionEvent.PRE_ITEM_CHANGE, CollectionType.REMOVE_ALL, -1, -1, temp));
			super.clear();
			this.dispatchEvent(new CollectionEvent(CollectionEvent.ITEM_CHANGE, CollectionType.REMOVE_ALL, -1, -1, temp));
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return "ArrayCollection: " + _elements.toString();
		}
		
		/**
		 * 注册事件侦听器对象, 以使侦听器能够接收事件通知.
		 * @param type 事件的类型.
		 * @param listener 处理事件的侦听器函数.
		 * @param useCapture 确定侦听器是运行于捕获阶段还是运行于目标和冒泡阶段.
		 * @param priority 事件侦听器的优先级.
		 * @param useWeakReference 确定对侦听器的引用是强引用, 还是弱引用.
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * 将事件调度到事件流中.
		 * @param event 调度到事件流中的事件对象.
		 * @return 除非对事件调用 <code>preventDefault()</code> (在这种情况下, 它返回 <code>false</code>), 否则值为 <code>true</code>.
		 */
		public function dispatchEvent(event:Event):Boolean
		{
			return _eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 * 检查对象是否为特定事件类型注册了任何侦听器.
		 * @param type 事件的类型.
		 * @return 如果指定类型的侦听器已注册则返回 <code>true</code>, 否则返回 <code>false</code>.
		 */
		public function hasEventListener(type:String):Boolean
		{
			return _eventDispatcher.hasEventListener(type);
		}
		
		/**
		 * 删除侦听器.
		 * @param type 事件的类型.
		 * @param listener 处理事件的侦听器函数.
		 * @param useCapture 指出是为捕获阶段还是为目标和冒泡阶段注册了侦听器.
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * 检查是否用此对象或其任何祖代为指定事件类型注册了事件侦听器.
		 * @param type 事件的类型.
		 * @return 如果将会触发指定类型的侦听器则返回 <code>true</code>, 否则返回 <code>false</code>.
		 */
		public function willTrigger(type:String):Boolean
		{
			return _eventDispatcher.willTrigger(type);
		}
	}
}
