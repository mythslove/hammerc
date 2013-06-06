/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.manager
{
	import flash.display.Sprite;
	
	import org.hammerc.core.hammerc_internal;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>LayerManager</code> 类管理应用或游戏 2D 显示的所有层次.
	 * <p>在 Hammerc 中显示层次至少应分为 6 层, 默认会创建这 6 层, 深度从下到上依次为: </p>
	 * <ul>
	 *   <li>applicationLayer 层: 用于显示应用或游戏的主体逻辑;</li>
	 *   <li>popUpLayer 层: 用于显示弹出窗体;</li>
	 *   <li>listLayer 层: 用于显示下拉菜单或菜单;</li>
	 *   <li>toolTipLayer 层: 用于显示工具提示;</li>
	 *   <li>dragAndDropLayer 层: 用于显示拖动图标;</li>
	 *   <li>cursorLayer 层: 用于显示自定义鼠标指针;</li>
	 * </ul>
	 * <p>默认创建的后 5 个层次大多数情况下应该位于较高的层次, 用户可以在创建层次后再添加一个或多个层.</p>
	 * @author wizardc
	 */
	public class LayerManager
	{
		private static var _instance:LayerManager;
		
		/**
		 * 获取本类的唯一实例.
		 * @return 本类的唯一实例.
		 */
		public static function getInstance():LayerManager
		{
			if(_instance == null)
			{
				_instance = new LayerManager(new SingletonEnforcer());
			}
			return _instance;
		}
		
		private var _root:Sprite;
		
		private var _applicationLayer:Sprite;
		private var _popUpLayer:Sprite;
		private var _listLayer:Sprite;
		private var _toolTipLayer:Sprite;
		private var _dragAndDropLayer:Sprite;
		private var _cursorLayer:Sprite;
		
		/**
		 * 本类为单例类不能实例化.
		 * @param singletonEnforcer 单例类实现对象.
		 */
		public function LayerManager(singletonEnforcer:SingletonEnforcer)
		{
			if(singletonEnforcer == null)
			{
				throw new Error("单例类不能进行实例化！");
			}
		}
		
		/**
		 * 获取应用层.
		 */
		public function get applicationLayer():Sprite
		{
			return _applicationLayer;
		}
		
		/**
		 * 获取弹窗层.
		 */
		public function get popUpLayer():Sprite
		{
			return _popUpLayer;
		}
		
		/**
		 * 获取菜单层.
		 */
		public function get listLayer():Sprite
		{
			return _listLayer;
		}
		
		/**
		 * 获取工具提示层.
		 */
		public function get toolTipLayer():Sprite
		{
			return _toolTipLayer;
		}
		
		/**
		 * 获取拖动图标层.
		 */
		public function get dragAndDropLayer():Sprite
		{
			return _dragAndDropLayer;
		}
		
		/**
		 * 获取鼠标指针层.
		 */
		public function get cursorLayer():Sprite
		{
			return _cursorLayer;
		}
		
		/**
		 * 初始化所有显示层次.
		 * @param root 程序顶级显示对象.
		 */
		hammerc_internal function initialize(root:Sprite):void
		{
			_root = root;
			//默认显示层
			_applicationLayer = new Sprite();
			_root.addChild(_applicationLayer);
			_popUpLayer = new Sprite();
			_root.addChild(_popUpLayer);
			_listLayer = new Sprite();
			_root.addChild(_listLayer);
			_toolTipLayer = new Sprite();
			_toolTipLayer.mouseEnabled = _toolTipLayer.mouseChildren = false;
			_root.addChild(_toolTipLayer);
			_dragAndDropLayer = new Sprite();
			_dragAndDropLayer.mouseEnabled = _dragAndDropLayer.mouseChildren = false;
			_root.addChild(_dragAndDropLayer);
			_cursorLayer = new Sprite();
			_cursorLayer.mouseEnabled = _cursorLayer.mouseChildren = false;
			_root.addChild(_cursorLayer);
		}
		
		/**
		 * 添加一个显示层.
		 * @param layer 添加的显示层对象.
		 * @param index 该层会被添加到的深度索引.
		 */
		public function addLayer(layer:Sprite, index:int):void
		{
			_root.addChildAt(layer, index);
		}
		
		/**
		 * 获取一个显示层深度索引.
		 * @param layer 指定的显示层对象.
		 * @return 指定的显示层深度索引.
		 */
		public function getLayerIndex(layer:Sprite):int
		{
			return _root.getChildIndex(layer);
		}
		
		/**
		 * 移除一个显示层.
		 * @param layer 要移除的显示层对象.
		 * @throws Error 移除的对象是基本显示层对象时抛出改异常.
		 */
		public function removeLayer(layer:Sprite):void
		{
			if(layer == _applicationLayer || layer == _popUpLayer || layer == _listLayer || layer == _toolTipLayer || layer == _dragAndDropLayer || layer == _cursorLayer)
			{
				throw new Error("不能移除默认的显示层对象！");
			}
			_root.removeChild(layer);
		}
	}
}

class SingletonEnforcer{}
