/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls
{
	import org.hammerc.controls.core.AbstractUIComponent;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.controls.AbstractSpacerSkin;
	
	/**
	 * <code>Spacer</code> 类定义一个不可见的间隔组件, 可用于占位.
	 * @author wizardc
	 */
	public class Spacer extends AbstractUIComponent
	{
		/**
		 * 创建一个 <code>Spacer</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function Spacer(skinClass:Class = null)
		{
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractSpacerSkin;
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
