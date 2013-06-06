/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	import org.hammerc.Global;
	
	/**
	 * <code>CustomCursorManager</code> 类为单例类, 提供管理自定义鼠标指针的功能.
	 * <p>Flash 自带的 <code>Mouse</code> 类可以设定系统级别的鼠标指针, 但是仅支持 32*32 大小及以下的位图, 本类提供相同的功能并支持设定鼠标指针为任何显示对象.</p>
	 * @author wizardc
	 */
	public class CustomCursorManager
	{
		private static var _instance:CustomCursorManager;
		
		/**
		 * 获取本类的唯一实例.
		 * @return 本类的唯一实例.
		 */
		public static function getInstance():CustomCursorManager
		{
			if(_instance == null)
			{
				_instance = new CustomCursorManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		private var _cursorLayer:Sprite;
		
		private var _cursorMap:Object;
		private var _nowCursor:CursorData;
		
		/**
		 * 本类为单例类不能实例化.
		 * @param singletonEnforcer 单例类实现对象.
		 */
		public function CustomCursorManager(singletonEnforcer:SingletonEnforcer)
		{
			if(singletonEnforcer == null)
			{
				throw new Error("单例类不能进行实例化！");
			}
			_cursorLayer = LayerManager.getInstance().cursorLayer;
			_cursorMap = new Object();
		}
		
		/**
		 * 设置或获取自定义鼠标指针层.
		 */
		public function set cursorLayer(value:Sprite):void
		{
			if(value == null)
			{
				throw new Error("属性\"cursorLayer\"不能设置为\"null\"！");
			}
			_cursorLayer = value;
		}
		public function get cursorLayer():Sprite
		{
			return _cursorLayer;
		}
		
		/**
		 * 获取当前显示的自定义鼠标指针.
		 */
		public function get nowCursor():DisplayObject
		{
			return _nowCursor.cursor;
		}
		
		/**
		 * 获取所有注册的自定义鼠标指针名称列表.
		 */
		public function get cursors():Vector.<String>
		{
			var result:Vector.<String> = new Vector.<String>();
			for(var key:String in _cursorMap)
			{
				result.push(key);
			}
			return result;
		}
		
		/**
		 * 注册一个自定义鼠标指针.
		 * @param name 名称.
		 * @param cursor 自定义鼠标指针.
		 * @param pivot 指针注册点偏移坐标.
		 */
		public function registerCursor(name:String, cursor:DisplayObject, pivot:Point = null):void
		{
			var cursorData:CursorData = new CursorData(cursor, pivot);
			_cursorMap[name] = cursorData;
		}
		
		/**
		 * 使用已注册的自定义鼠标指针, 没有指定的名称时保持原有指针.
		 * @param name 名称.
		 * @return 当前显示的自定义鼠标指针.
		 */
		public function useCursor(name:String):DisplayObject
		{
			var cursorData:CursorData;
			if(_cursorMap.hasOwnProperty(name))
			{
				cursorData = _cursorMap[name] as CursorData;
				if(_nowCursor == null)
				{
					Mouse.hide();
					Global.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				}
				else
				{
					_cursorLayer.removeChild(_nowCursor.cursor);
				}
				_nowCursor = cursorData;
				if(_nowCursor.cursor is InteractiveObject)
				{
					(_nowCursor.cursor as InteractiveObject).mouseEnabled = false;
				}
				if(_nowCursor.cursor is DisplayObjectContainer)
				{
					(_nowCursor.cursor as DisplayObjectContainer).mouseChildren = false;
				}
				_nowCursor.updatePosition(new Point(_cursorLayer.mouseX, _cursorLayer.mouseY));
				return _cursorLayer.addChild(_nowCursor.cursor);
			}
			return null;
		}
		
		private function mouseMoveHandler(event:MouseEvent):void
		{
			var point:Point = _nowCursor.cursor.parent.globalToLocal(new Point(event.stageX, event.stageY));
			_nowCursor.updatePosition(point);
			//立即更新显示对象
			event.updateAfterEvent();
		}
		
		/**
		 * 使用系统自带的鼠标指针.
		 */
		public function useSystemCursor():void
		{
			if(_nowCursor != null)
			{
				_cursorLayer.removeChild(_nowCursor.cursor);
				Mouse.show();
				Global.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				_nowCursor = null;
			}
		}
		
		/**
		 * 获取指定名称的自定义鼠标指针.
		 * @param name 名称.
		 * @return 指定名称的自定义鼠标指针.
		 */
		public function getCursor(name:String):DisplayObject
		{
			var cursorData:CursorData = _cursorMap[name] as CursorData;
			if(cursorData != null)
			{
				return cursorData.cursor;
			}
			return null;
		}
		
		/**
		 * 注销一个注册的自定义鼠标指针.
		 * @param name 名称.
		 * @return 指定名称的自定义鼠标指针.
		 */
		public function unregisterCursor(name:String):DisplayObject
		{
			var cursorData:CursorData = _cursorMap[name] as CursorData;
			if(cursorData != null)
			{
				if(_nowCursor == cursorData)
				{
					this.useSystemCursor();
				}
				delete _cursorMap[name];
				return cursorData.cursor;
			}
			return null;
		}
		
		/**
		 * 注销所有注册的自定义鼠标指针.
		 */
		public function unregisterAllCursor():void
		{
			if(_nowCursor != null)
			{
				this.useSystemCursor();
			}
			_cursorMap = new Object();
		}
	}
}

import flash.display.DisplayObject;
import flash.geom.Point;

class SingletonEnforcer{}

/**
 * <code>CursorData</code> 类记录一个自定义鼠标指针的所有数据.
 */
class CursorData
{
	/**
	 * 指针显示对象.
	 */
	public var cursor:DisplayObject;
	
	/**
	 * 指针注册点.
	 */
	public var pivot:Point;
	
	/**
	 * 创建一个 <code>CursorData</code> 对象.
	 * @param cursor 指针显示对象.
	 * @param pivot 指针注册点.
	 */
	public function CursorData(cursor:DisplayObject, pivot:Point = null)
	{
		this.cursor = cursor;
		this.pivot = pivot;
	}
	
	/**
	 * 更新鼠标指针的坐标.
	 * @param point 鼠标指针的坐标.
	 */
	public function updatePosition(point:Point):void
	{
		if(this.pivot != null)
		{
			point = point.subtract(this.pivot);
		}
		this.cursor.x = point.x;
		this.cursor.y = point.y;
	}
}
