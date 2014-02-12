/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi
{
	import org.hammerc.containers.*;
	import org.hammerc.controls.*;
	import org.hammerc.manager.ToolTipManager;
	import org.hammerc.themes.AbstractTheme;
	import org.hammerc.themes.hi.containers.*;
	import org.hammerc.themes.hi.controls.*;
	import org.hammerc.themes.hi.toolTips.*;
	
	/**
	 * <code>HiTheme</code> 类定义了一组纯代码绘制的简单 UI 主题, 主要用于快速搭建测试程序时使用.
	 * @author wizardc
	 */
	public class HiTheme extends AbstractTheme
	{
		/**
		 * 创建一个 <code>HiTheme</code> 对象.
		 */
		public function HiTheme()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			//容器
			this.mapDefaultSkin(Canvas, HiCanvasSkin);
			this.mapDefaultSkin(HBox, HiHBoxSkin);
			this.mapDefaultSkin(Panel, HiPanelSkin);
			this.mapDefaultSkin(VBox, HiVBoxSkin);
			//控件
			this.mapDefaultSkin(Button, HiButtonSkin);
			this.mapDefaultSkin(CheckBox, HiCheckBoxSkin);
			this.mapDefaultSkin(HScrollBar, HiHScrollBarSkin);
			this.mapDefaultSkin(Label, HiLabelSkin);
			this.mapDefaultSkin(ProgressBar, HiProgressBarSkin);
			this.mapDefaultSkin(RadioButton, HiRadioButtonSkin);
			this.mapDefaultSkin(SimplestButton, HiSimplestButtonSkin);
			this.mapDefaultSkin(Spacer, HiSpacerSkin);
			this.mapDefaultSkin(TextArea, HiTextAreaSkin);
			this.mapDefaultSkin(TextInput, HiTextInputSkin);
			this.mapDefaultSkin(ToggleButton, HiToggleButtonSkin);
			this.mapDefaultSkin(VScrollBar, HiVScrollBarSkin);
			//工具提示
			ToolTipManager.getInstance().defaultToolTipRenderer = HiTextToolTipRender;
		}
	}
}
