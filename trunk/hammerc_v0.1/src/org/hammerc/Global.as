/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.manager.FocusManager;
	import org.hammerc.manager.LayerManager;
	import org.hammerc.manager.SkinManager;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>Global</code> 类为整个类库提供全局的支持.
	 * @author wizardc
	 */
	public class Global
	{
		private static var _root:DisplayObject;
		
		/**
		 * 获取根显示对象.
		 */
		public static function get root():DisplayObject
		{
			return _root;
		}
		
		/**
		 * 获取舞台对象.
		 */
		public static function get stage():Stage
		{
			return _root.stage;
		}
		
		/**
		 * 获取应用层.
		 */
		public static function get applicationLayer():Sprite
		{
			return LayerManager.getInstance().applicationLayer;
		}
		
		/**
		 * 获取弹窗层.
		 */
		public static function get popUpLayer():Sprite
		{
			return LayerManager.getInstance().popUpLayer;
		}
		
		/**
		 * 获取菜单层.
		 */
		public static function get listLayer():Sprite
		{
			return LayerManager.getInstance().listLayer;
		}
		
		/**
		 * 获取工具提示层.
		 */
		public static function get toolTipLayer():Sprite
		{
			return LayerManager.getInstance().toolTipLayer;
		}
		
		/**
		 * 获取拖动图标层.
		 */
		public static function get dragAndDropLayer():Sprite
		{
			return LayerManager.getInstance().dragAndDropLayer;
		}
		
		/**
		 * 获取鼠标指针层.
		 */
		public static function get cursorLayer():Sprite
		{
			return LayerManager.getInstance().cursorLayer;
		}
		
		/**
		 * 初始化 Hammerc 类库.
		 * @param root 应用程序根显示对象.
		 */
		public static function initialize(root:DisplayObject):void
		{
			_root = root;
			LayerManager.getInstance().hammerc_internal::initialize(_root as Sprite);
			FocusManager.getInstance().hammerc_internal::initialize(_root.stage);
		}
		
		/**
		 * 注册使用的默认主题类.
		 * @param themeClass 要被注册的默认主题对象.
		 */
		public static function registerDefaultTheme(themeClass:Class):void
		{
			SkinManager.getInstance().registerDefaultTheme(themeClass);
		}
	}
}
