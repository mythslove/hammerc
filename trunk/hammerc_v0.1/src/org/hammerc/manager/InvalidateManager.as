/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager
{
	import flash.events.Event;
	
	import org.hammerc.Global;
	import org.hammerc.manager.invalidateClasses.IInvalidating;
	import org.hammerc.manager.invalidateClasses.NestQueue;
	
	/**
	 * <code>InvalidateManager</code> 类管理所有需要在呈现之前对内部对象进行布局和重绘的组件对象.
	 * @author wizardc
	 */
	public class InvalidateManager
	{
		private static var _instance:InvalidateManager;
		
		/**
		 * 获取本类的唯一实例.
		 * @return 本类的唯一实例.
		 */
		public static function getInstance():InvalidateManager
		{
			if(_instance == null)
			{
				_instance = new InvalidateManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		private var _hasListener:Boolean = false;
		
		private var _invalidateLayoutFlag:Boolean = false;
		private var _invalidateLayoutList:Vector.<IInvalidating>;
		
		private var _layoutProgressing:Boolean = false;
		private var _invalidateLayoutQueue:NestQueue;
		
		private var _invalidateShowFlag:Boolean = false;
		private var _invalidateShowList:Vector.<IInvalidating>;
		
		/**
		 * 本类为单例类不能实例化.
		 * @param singletonEnforcer 单例类实现对象.
		 */
		public function InvalidateManager(singletonEnforcer:SingletonEnforcer)
		{
			if(singletonEnforcer == null)
			{
				throw new Error("单例类不能进行实例化！");
			}
			_invalidateLayoutList = new Vector.<IInvalidating>();
			_invalidateLayoutQueue = new NestQueue();
			_invalidateShowList = new Vector.<IInvalidating>();
		}
		
		/**
		 * 注册一个布局已经失效的对象, 该对象的更新布局方法会在下一帧呈现之前被调用.
		 * @param invalidating 布局已经失效的对象.
		 */
		public function invalidateLayout(invalidating:IInvalidating):void
		{
			if(!_invalidateLayoutFlag)
			{
				_invalidateLayoutFlag = true;
				if(!_hasListener)
				{
					_hasListener = true;
					addLayoutListener();
				}
			}
			if(!_layoutProgressing)
			{
				if(_invalidateLayoutList.indexOf(invalidating) == -1)
				{
					_invalidateLayoutList.push(invalidating);
				}
			}
			else
			{
				invalidating.calculateNestLevel();
				_invalidateLayoutQueue.append(invalidating);
			}
		}
		
		/**
		 * 注册一个显示已经失效的对象, 该对象皮肤类的重绘方法会在下一帧呈现之前被调用.
		 * @param invalidating 显示已经失效的对象.
		 */
		public function invalidateShow(invalidating:IInvalidating):void
		{
			if(!_invalidateShowFlag)
			{
				_invalidateShowFlag = true;
				if(!_hasListener)
				{
					_hasListener = true;
					addLayoutListener();
				}
			}
			if(_invalidateShowList.indexOf(invalidating) == -1)
			{
				_invalidateShowList.push(invalidating);
			}
		}
		
		private function addLayoutListener():void
		{
			Global.stage.addEventListener(Event.ENTER_FRAME, layoutHandler, false, int.MIN_VALUE);
		}
		
		private function layoutHandler(event:Event):void
		{
			Global.stage.removeEventListener(Event.ENTER_FRAME, layoutHandler);
			_hasListener = false;
			var invalidating:IInvalidating;
			//布局阶段
			if(_invalidateLayoutFlag)
			{
				_invalidateLayoutFlag = false;
				//记录当前正在更新布局
				_layoutProgressing = true;
				//添加所有待处理的布局组件到布局排序队列中
				for each(invalidating in _invalidateLayoutList)
				{
					invalidating.calculateNestLevel();
					_invalidateLayoutQueue.append(invalidating);
				}
				_invalidateLayoutList.length = 0;
				//按 nestLevel 从小到大的排列取出所有的待布局对象并进行布局
				invalidating = _invalidateLayoutQueue.removeSmallest();
				while(invalidating != null)
				{
					invalidating.validateLayout();
					invalidating = _invalidateLayoutQueue.removeSmallest();
				}
				//清除排序队列
				if(!_invalidateLayoutQueue.isEmpty())
				{
					_invalidateLayoutQueue.clear();
				}
				//记录本次布局更新完成
				_layoutProgressing = false;
			}
			//重绘阶段
			if(_invalidateShowFlag)
			{
				_invalidateShowFlag = false;
				for each(invalidating in _invalidateShowList)
				{
					invalidating.validateShow();
				}
				_invalidateShowList.length = 0;
			}
		}
	}
}

class SingletonEnforcer{}
