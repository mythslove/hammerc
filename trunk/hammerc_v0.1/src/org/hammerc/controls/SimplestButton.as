/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls
{
	import org.hammerc.controls.buttonClasses.AbstractButtonBase;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.controls.AbstractSimplestButtonSkin;
	
	/**
	 * <code>SimplestButton</code> 类定义一个仅显示图形的简单按钮.
	 * @author wizardc
	 */
	public class SimplestButton extends AbstractButtonBase
	{
		/**
		 * 创建一个 <code>SimplestButton</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function SimplestButton(skinClass:Class = null)
		{
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractSimplestButtonSkin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createDefaultSkin():ISkin
		{
			return SkinManager.getInstance().defaultTheme.getDefaultSkin(this);
		}
	}
}
