/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.themes.hi.controls
{
	import org.hammerc.controls.ProgressBar;
	import org.hammerc.controls.core.IUIComponent;
	import org.hammerc.controls.core.OrientationType;
	import org.hammerc.controls.supportClasses.Margin;
	import org.hammerc.skin.controls.AbstractProgressBarSkin;
	import org.hammerc.themes.hi.HiThemeStyle;
	
	/**
	 * <code>HiProgressBarSkin</code> 类定义了 Hi 主题的进度条组件皮肤.
	 * @author wizardc
	 */
	public class HiProgressBarSkin extends AbstractProgressBarSkin
	{
		/**
		 * 创建一个 <code>HiProgressBarSkin</code> 对象.
		 * @param owner 该皮肤对象对应的组件.
		 */
		public function HiProgressBarSkin(owner:IUIComponent)
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
			//设置样式
			_background.filters = [HiThemeStyle.getShadow(3, true)];
			//设置默认属性
			var fillBarMargin:Margin = this.getOwner().fillBarMargin;
			fillBarMargin.top = fillBarMargin.bottom = fillBarMargin.left = fillBarMargin.right = 1;
			this.getOwner().fillBarMargin = fillBarMargin;
			this.getOwner().setSize(100, 10);
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
			this.getOwner().alpha = enabled ? 1 : .5;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function fillBarChange():void
		{
			drawFillBar();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onValueChanged(value:Number):void
		{
			drawFillBar();
		}
		
		private function drawFillBar():void
		{
			var owner:ProgressBar = this.getOwner();
			var fillBarWidth:Number = owner.width - owner.fillBarMargin.left - owner.fillBarMargin.right;
			var fillBarHeight:Number = owner.height - owner.fillBarMargin.top - owner.fillBarMargin.bottom;
			var progress:Number = (owner.value - owner.mininum) / (owner.maxinum - owner.mininum);
			_fillBar.graphics.clear();
			var progressSize:Number;
			if(progress > 0)
			{
				if(owner.orientation == OrientationType.HORIZONTAL)
				{
					progressSize = progress * fillBarWidth;
					_fillBar.graphics.beginFill(HiThemeStyle.BUTTON_BORDER);
					_fillBar.graphics.drawRect(1, 1, progressSize, fillBarHeight);
					_fillBar.graphics.endFill();
					_fillBar.graphics.beginFill(HiThemeStyle.BUTTON_FACE);
					_fillBar.graphics.drawRect(0, 0, progressSize, fillBarHeight);
					_fillBar.graphics.endFill();
				}
				else
				{
					progressSize = progress * fillBarHeight;
					_fillBar.graphics.beginFill(HiThemeStyle.BUTTON_BORDER);
					_fillBar.graphics.drawRect(1, fillBarHeight - progressSize + 1, fillBarWidth, progressSize);
					_fillBar.graphics.endFill();
					_fillBar.graphics.beginFill(HiThemeStyle.BUTTON_FACE);
					_fillBar.graphics.drawRect(0, fillBarHeight - progressSize, fillBarWidth, progressSize);
					_fillBar.graphics.endFill();
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function drawSkin():void
		{
			_background.graphics.clear();
			_background.graphics.beginFill(HiThemeStyle.BACKGROUND);
			_background.graphics.drawRect(0, 0, this.getOwner().width, this.getOwner().height);
			_background.graphics.endFill();
		}
	}
}
