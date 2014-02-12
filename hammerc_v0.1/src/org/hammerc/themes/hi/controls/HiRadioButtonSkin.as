/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.controls
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import org.hammerc.controls.Label;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.controls.supportClasses.Margin;
	import org.hammerc.skin.controls.AbstractRadioButtonSkin;
	import org.hammerc.themes.hi.HiThemeStyle;
	
	/**
	 * <code>HiRadioButtonSkin</code> 类定义了 Hi 主题单选按钮皮肤.
	 * @author wizardc
	 */
	public class HiRadioButtonSkin extends AbstractRadioButtonSkin
	{
		/**
		 * 绘制左侧的小格子.
		 */
		protected var _box:Sprite;
		
		/**
		 * 绘制选中时的小方块.
		 */
		protected var _square:Shape;
		
		/**
		 * 创建一个 <code>HiRadioButtonSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiRadioButtonSkin(owner:IUIComponent)
		{
			super(owner);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function init():void
		{
			_labelSkinClass = HiLabelSkin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function addChildren():void
		{
			//创建小方块
			_box = new Sprite();
			_box.graphics.beginFill(HiThemeStyle.PANEL_BORDER);
			_box.graphics.drawCircle(6, 6, 6);
			_box.graphics.endFill();
			_box.x = _box.y = 5;
			_box.filters = [HiThemeStyle.getShadow(3, true)];
			this.getOwner().addChild(_box);
			_square = new Shape();
			_square.graphics.beginFill(HiThemeStyle.BUTTON_BORDER);
			_square.graphics.drawCircle(4, 4, 3);
			_square.graphics.endFill();
			_square.graphics.beginFill(HiThemeStyle.BUTTON_FACE);
			_square.graphics.drawCircle(3, 3, 3);
			_square.graphics.endFill();
			_square.x = _square.y = 3;
			_square.visible = false;
			_box.addChild(_square);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function configuration():void
		{
			super.configuration();
			//设置默认属性
			this.getOwner().height = 22;
			this.getOwner().label = "Radio Button";
			var labelMargin:Margin = this.getOwner().labelMargin;
			labelMargin.left = 22;
			labelMargin.right = 5;
			this.getOwner().labelMargin = labelMargin;
			this.getOwner().adjustSizeWithLabel(true, false);
			this.getOwner().veticallyLabel();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function removeChildren():void
		{
			this.getOwner().removeChild(_box);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function createLabel():Label
		{
			return new Label(_labelSkinClass);
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
			this.getOwner().alpha = enabled ? 1 : .5;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onStateChanged(state:int):void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onSelectedChanged(selected:Boolean):void
		{
			_square.visible = selected;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function drawSkin():void
		{
			_background.graphics.clear();
			_background.graphics.beginFill(0x000000, 0);
			_background.graphics.drawRect(0, 0, this.getOwner().width, this.getOwner().height);
			_background.graphics.endFill();
		}
	}
}
