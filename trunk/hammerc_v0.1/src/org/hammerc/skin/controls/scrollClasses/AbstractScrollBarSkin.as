/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.skin.controls.scrollClasses
{
	import flash.display.Sprite;
	
	import org.hammerc.controls.buttonClasses.AbstractButtonBase;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.controls.scrollClasses.AbstractScrollBar;
	import org.hammerc.core.AbstractEnforcer;
	import org.hammerc.core.hammerc_internal;
	import org.hammerc.skin.AbstractSkin;
	
	use namespace hammerc_internal;
	
	/**
	 * <code>AbstractButtonBaseSkin</code> 类为滚动条对象的皮肤基类.
	 * @author wizardc
	 */
	public class AbstractScrollBarSkin extends AbstractSkin
	{
		/**
		 * 记录组件内部用于显示滚动条背景的容器对象.
		 */
		protected var _background:Sprite;
		
		/**
		 * 记录向上或向左的箭头按钮.
		 */
		protected var _upOrLeftButton:AbstractButtonBase;
		
		/**
		 * 记录向上或向左的箭头按钮使用的皮肤类对象.
		 */
		protected var _upOrLeftButtonSkinClass:Class;
		
		/**
		 * 记录向下或向右的箭头按钮.
		 */
		protected var _bottomOrRightButton:AbstractButtonBase;
		
		/**
		 * 记录向下或向右的箭头按钮使用的皮肤类对象.
		 */
		protected var _bottomOrRightButtonSkinClass:Class;
		
		/**
		 * 记录滑块按钮.
		 */
		protected var _sliderButton:AbstractButtonBase;
		
		/**
		 * 记录滑块按钮使用的皮肤类对象.
		 */
		protected var _sliderButtonSkinClass:Class;
		
		/**
		 * <code>AbstractScrollBarSkin</code> 类为抽象类, 不能被实例化.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function AbstractScrollBarSkin(owner:IUIComponent)
		{
			AbstractEnforcer.enforceConstructor(this, AbstractScrollBarSkin);
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function configuration():void
		{
			_background = (_owner as AbstractScrollBar).hammerc_internal::background;
			_upOrLeftButton = (_owner as AbstractScrollBar).hammerc_internal::upOrLeftButton;
			_bottomOrRightButton = (_owner as AbstractScrollBar).hammerc_internal::bottomOrRightButton;
			_sliderButton = (_owner as AbstractScrollBar).hammerc_internal::sliderButton;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function changeChildrenSkinClass():void
		{
			_upOrLeftButton.skinClass = _upOrLeftButtonSkinClass;
			_bottomOrRightButton.skinClass = _bottomOrRightButtonSkinClass;
			_sliderButton.skinClass = _sliderButtonSkinClass;
		}
		
		/**
		 * 创建组件内部使用的向上或向左的箭头按钮对象.
		 * @return 组件内部使用的向上或向左的箭头按钮对象.
		 */
		public function createUpOrLeftButton():AbstractButtonBase
		{
			return null;
		}
		
		/**
		 * 创建组件内部使用的向下或向右的箭头按钮对象.
		 * @return 组件内部使用的向下或向右的箭头按钮对象.
		 */
		public function createBottomOrRightButton():AbstractButtonBase
		{
			return null;
		}
		
		/**
		 * 创建组件内部使用的滑块按钮对象.
		 * @return 组件内部使用的滑块按钮对象.
		 */
		public function createSliderButton():AbstractButtonBase
		{
			return null;
		}
	}
}
