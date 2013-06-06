/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.controls
{
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.skin.controls.AbstractSpacerSkin;
	
	/**
	 * <code>HiSpacerSkin</code> 类定义了 Hi 主题的间隔组件皮肤.
	 * @author wizardc
	 */
	public class HiSpacerSkin extends AbstractSpacerSkin
	{
		/**
		 * 创建一个 <code>HiSpacerSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiSpacerSkin(owner:IUIComponent)
		{
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function addChildren():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function configuration():void
		{
			super.configuration();
			//设置默认属性
			this.getOwner().setSize(30, 30);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function removeChildren():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onSizeChanged(width:Number, height:Number):void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onEnabledChanged(enabled:Boolean):void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override public function drawSkin():void
		{
		}
	}
}
