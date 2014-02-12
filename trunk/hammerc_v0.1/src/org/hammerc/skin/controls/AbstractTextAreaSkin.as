/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls
{
	import flash.display.Sprite;
	
	import org.hammerc.controls.HScrollBar;
	import org.hammerc.controls.TextArea;
	import org.hammerc.controls.VScrollBar;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.controls.textClasses.AbstractTextSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractTextAreaSkin</code> 类为多行文本字段对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractTextAreaSkin extends AbstractTextSkin
	{
		/**
		 * 记录背景显示对象.
		 */
		protected var _background:Sprite;
		
		/**
		 * 记录水平滚动条对象.
		 */
		protected var _horizontalScrollBar:HScrollBar;
		
		/**
		 * 记录水平滚动条使用的皮肤类对象.
		 */
		protected var _horizontalScrollBarSkinClass:Class;
		
		/**
		 * 记录垂直滚动条对象.
		 */
		protected var _verticalScrollBar:VScrollBar;
		
		/**
		 * 记录垂直滚动条使用的皮肤类对象.
		 */
		protected var _verticalScrollBarSkinClass:Class;
		
		/**
		 * <code>AbstractTextAreaSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractTextAreaSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractTextAreaSkin);
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function configuration():void
		{
			super.configuration();
			_background = this.getOwner().hammerc_internal::background;
			_horizontalScrollBar = this.getOwner().hammerc_internal::horizontalScrollBar;
			_verticalScrollBar = this.getOwner().hammerc_internal::verticalScrollBar;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function changeChildrenSkinClass():void
		{
			_horizontalScrollBar.skinClass = _horizontalScrollBarSkinClass;
			_verticalScrollBar.skinClass = _verticalScrollBarSkinClass;
		}
		
		/**
		 * 获取该皮肤对象对应的组件.
		 * @return 该皮肤对象对应的组件.
		 */
		protected function getOwner():TextArea
		{
			return _owner as TextArea;
		}
		
		/**
		 * 创建组件内部使用的水平滚动条对象.
		 * @return 组件内部使用的水平滚动条对象.
		 */
		public function createHorizontalScrollBar():HScrollBar
		{
			return null;
		}
		
		/**
		 * 创建组件内部使用的垂直滚动条对象.
		 * @return 组件内部使用的垂直滚动条对象.
		 */
		public function createVerticalScrollBar():VScrollBar
		{
			return null;
		}
	}
}
