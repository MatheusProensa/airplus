package com.sulake.habbo.window.utils.tableview
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TableCellView implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromTableCellView_TableView_1:TableView;
      
      private var UnknownVarFromTableCellView_TableRowView_1:TableRowView;
      
      private var UnknownVarFromTableCellView_String_1:String;
      
      private var UnknownVarFromTableCellView_TableCell_1:TableCell;
      
      private var _container:IRegionWindow;
      
      private var _transitionTimer:Timer;
      
      public function TableCellView(param1:TableView, param2:TableRowView, param3:String, param4:TableCell)
      {
         super();
         UnknownVarFromTableCellView_TableView_1 = param1;
         UnknownVarFromTableCellView_TableRowView_1 = param2;
         UnknownVarFromTableCellView_String_1 = param3;
         UnknownVarFromTableCellView_TableCell_1 = param4;
         _container = template.clone() as IRegionWindow;
         updateWidth();
         initializeView();
         _container.addEventListener("WME_DOUBLE_CLICK",onDoubleClick);
         _container.addEventListener("WME_DOWN",param2.onDown);
         _container.addEventListener("WME_OVER",param2.onHoverOver);
         _container.addEventListener("WME_OUT",param2.onHoverOut);
         _container.addEventListener("WME_CLICK_AWAY",param2.onClickAway);
         _container.mouseThreshold = 0;
      }
      
      private static function easeInOutCubic(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param1 / param4;
         var _loc6_:Number = -(_loc5_ * 1.75 - 0.7) * (_loc5_ * 1.75 - 0.7) + 1;
         return param2 + param3 * _loc6_;
      }
      
      public function reuse(param1:TableCell) : void
      {
         UnknownVarFromTableCellView_TableCell_1 = param1;
         initializeView();
      }
      
      public function update(param1:TableCell) : void
      {
         UnknownVarFromTableCellView_TableCell_1 = param1;
         var _loc2_:ITextFieldWindow = getInputElement(false);
         if(_loc2_ != null && Boolean(_loc2_.visible))
         {
            updateContents();
         }
         else
         {
            initializeView();
            if(param1.highlightOnChange)
            {
               highlight();
            }
         }
      }
      
      private function setAllInvisible() : void
      {
         var _loc3_:ITextWindow = getTextElement(false);
         var _loc4_:ITextFieldWindow = getInputElement(false);
         var _loc2_:IRegionWindow = getLinkRegion(false);
         var _loc1_:IRegionWindow = getExtraButtonRegion(false);
         turnInvisible(_loc3_);
         turnInvisible(_loc4_);
         turnInvisible(_loc2_);
         turnInvisible(_loc1_);
      }
      
      private function turnInvisible(param1:IWindowModel) : void
      {
         if(param1 != null)
         {
            param1.visible = false;
         }
      }
      
      private function onLinkClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromTableCellView_TableCell_1 != null && UnknownVarFromTableCellView_TableCell_1.linkClickCallback != null)
         {
            UnknownVarFromTableCellView_TableCell_1.linkClickCallback();
         }
      }
      
      private function onExtraButtonClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromTableCellView_TableCell_1 != null && UnknownVarFromTableCellView_TableCell_1.extraBtnCallback != null)
         {
            UnknownVarFromTableCellView_TableCell_1.extraBtnCallback();
         }
      }
      
      private function initializeView() : void
      {
         setAllInvisible();
         if(UnknownVarFromTableCellView_TableCell_1.type == TableCell.UnknownVarFromTableCell_Int_1)
         {
            getLinkRegion(true).visible = true;
         }
         else if(UnknownVarFromTableCellView_TableCell_1.type == TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1)
         {
            getTextElement(true).visible = true;
         }
         updateContents();
      }
      
      private function updateContents() : void
      {
         var _loc3_:ITextWindow = null;
         if(UnknownVarFromTableCellView_TableCell_1.type == TableCell.UnknownVarFromTableCell_Int_1)
         {
            getLinkElement(true).text = UnknownVarFromTableCellView_TableCell_1.contents as String;
         }
         else if(UnknownVarFromTableCellView_TableCell_1.type == TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1)
         {
            _loc3_ = getTextElement(true);
            _loc3_.textColor = UnknownVarFromTableCellView_TableCell_1.textColor;
            _loc3_.autoSize = column.alignment;
            _loc3_.text = UnknownVarFromTableCellView_TableCell_1.contents as String;
         }
         var _loc2_:String = "";
         if(UnknownVarFromTableCellView_TableCell_1.tooltipText != null)
         {
            _loc2_ = UnknownVarFromTableCellView_TableCell_1.tooltipText;
         }
         else if(UnknownVarFromTableCellView_TableCell_1.type == TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1 && _loc3_ != null && _loc3_.isOverflown)
         {
            _loc2_ = UnknownVarFromTableCellView_TableCell_1.contents as String;
         }
         _container.toolTipCaption = _loc2_;
         var _loc1_:IRegionWindow = getExtraButtonRegion(false);
         if(UnknownVarFromTableCellView_TableCell_1.extraBtn != null)
         {
            _loc1_ = getExtraButtonRegion(true);
            _loc1_.visible = true;
            getExtraButton(true).assetUri = UnknownVarFromTableCellView_TableCell_1.extraBtn;
            _loc1_.interactiveCursorDisabled = UnknownVarFromTableCellView_TableCell_1.extraBtnCallback == null;
         }
         else if(_loc1_ != null)
         {
            _loc1_.visible = false;
         }
      }
      
      private function get column() : TableColumn
      {
         return UnknownVarFromTableCellView_TableView_1.getColumnById(UnknownVarFromTableCellView_String_1);
      }
      
      public function updateWidth() : void
      {
         _container.width = UnknownVarFromTableCellView_TableView_1.getCellWidth(UnknownVarFromTableCellView_String_1);
      }
      
      public function get container() : IWindowController_1
      {
         return _container;
      }
      
      private function onInputEdit(param1:WindowEvent) : void
      {
         var _loc2_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ITextFieldWindow = getInputElement(false);
         if(_loc2_.keyCode == 13 && UnknownVarFromTableCellView_TableCell_1.isEditable)
         {
            UnknownVarFromTableCellView_TableView_1.onEnterNewCellValue(_loc3_.text,UnknownVarFromTableCellView_TableRowView_1.object,UnknownVarFromTableCellView_String_1);
            initializeView();
         }
         else if(_loc2_.keyCode == 27)
         {
            initializeView();
         }
      }
      
      private function onInputFocusOut(param1:WindowEvent) : void
      {
         initializeView();
      }
      
      private function onDoubleClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextFieldWindow = null;
         if(UnknownVarFromTableCellView_TableCell_1.isInspectable || UnknownVarFromTableCellView_TableCell_1.isEditable)
         {
            setAllInvisible();
            _loc2_ = getInputElement(true);
            _loc2_.visible = true;
            _loc2_.text = UnknownVarFromTableCellView_TableCell_1.textFieldValue;
            _loc2_.editable = UnknownVarFromTableCellView_TableCell_1.isEditable;
            _loc2_.focus();
         }
      }
      
      public function recycle() : void
      {
         UnknownVarFromTableCellView_TableCell_1 = null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _container.dispose();
         UnknownVarFromTableCellView_String_1 = null;
         UnknownVarFromTableCellView_TableView_1 = null;
         _container = null;
         UnknownVarFromTableCellView_TableCell_1 = null;
         _disposed = true;
         if(_transitionTimer != null)
         {
            _transitionTimer.reset();
            _transitionTimer = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function getTextElement(param1:Boolean) : ITextWindow
      {
         var _loc2_:ITextWindow = _container.findChildByName("element_text") as ITextWindow;
         if(_loc2_ == null && param1)
         {
            return template.createElementText(_container) as ITextWindow;
         }
         return _loc2_;
      }
      
      private function getInputElement(param1:Boolean) : ITextFieldWindow
      {
         var _loc3_:ITextFieldWindow = null;
         var _loc2_:ITextFieldWindow = _container.findChildByName("element_input") as ITextFieldWindow;
         if(_loc2_ == null && param1)
         {
            _loc3_ = template.createElementInput(_container) as ITextFieldWindow;
            _loc3_.addEventListener("WKE_KEY_DOWN",onInputEdit);
            _loc3_.addEventListener("WKE_KEY_UP",onInputEdit);
            _loc3_.addEventListener("WE_UNFOCUS",onInputFocusOut);
            _loc3_.addEventListener("WME_CLICK_AWAY",UnknownVarFromTableCellView_TableRowView_1.onClickAway);
            return _loc3_;
         }
         return _loc2_;
      }
      
      private function getLinkRegion(param1:Boolean) : IRegionWindow
      {
         var _loc3_:IRegionWindow = null;
         var _loc2_:IRegionWindow = _container.findChildByName("link_container") as IRegionWindow;
         if(_loc2_ == null && param1)
         {
            _loc3_ = template.createLinkContainer(_container) as IRegionWindow;
            _loc3_.addEventListener("WME_DOWN",UnknownVarFromTableCellView_TableRowView_1.onDown);
            _loc3_.addEventListener("WME_OVER",UnknownVarFromTableCellView_TableRowView_1.onHoverOver);
            _loc3_.addEventListener("WME_OUT",UnknownVarFromTableCellView_TableRowView_1.onHoverOut);
            _loc3_.addEventListener("WME_CLICK_AWAY",UnknownVarFromTableCellView_TableRowView_1.onClickAway);
            _loc3_.addEventListener("WME_CLICK",onLinkClick);
            _loc3_.mouseThreshold = 0;
            return _loc3_;
         }
         return _loc2_;
      }
      
      private function getLinkElement(param1:Boolean) : ITextWindow
      {
         var _loc2_:IRegionWindow = getLinkRegion(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.findChildByName("element_link") as ITextWindow;
      }
      
      private function getHighlightBorder(param1:Boolean) : UnknownICoreWindowComponents6
      {
         var _loc2_:UnknownICoreWindowComponents6 = _container.findChildByName("highlight_border") as UnknownICoreWindowComponents6;
         if(_loc2_ == null && param1)
         {
            return template.createHighlightBorder(_container) as UnknownICoreWindowComponents6;
         }
         return _loc2_;
      }
      
      private function getExtraButtonRegion(param1:Boolean) : IRegionWindow
      {
         var _loc3_:IRegionWindow = null;
         var _loc2_:IRegionWindow = _container.findChildByName("extra_button") as IRegionWindow;
         if(_loc2_ == null && param1)
         {
            _loc3_ = template.createExtraButton(_container) as IRegionWindow;
            _loc3_.addEventListener("WME_CLICK",onExtraButtonClick);
            _loc3_.addEventListener("WME_OVER",UnknownVarFromTableCellView_TableRowView_1.onHoverOver);
            _loc3_.addEventListener("WME_OUT",UnknownVarFromTableCellView_TableRowView_1.onHoverOut);
            return _loc3_;
         }
         return _loc2_;
      }
      
      private function getExtraButton(param1:Boolean) : IStaticBitmapWrapperWindow
      {
         var _loc2_:IRegionWindow = getExtraButtonRegion(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.findChildByName("extra_button_bitmap") as IStaticBitmapWrapperWindow;
      }
      
      private function get template() : CellTemplate
      {
         return UnknownVarFromTableCellView_TableView_1.cellTemplate;
      }
      
      private function highlight() : void
      {
         var highlightBorder:UnknownICoreWindowComponents6;
         var transitionDuration:Number;
         var delay:int;
         var steps:int;
         var minValue:Number;
         var maxValue:Number;
         var updateValue:* = function(param1:TimerEvent):void
         {
            var _loc2_:Number = easeInOutCubic(_transitionTimer.currentCount,minValue,maxValue - minValue,steps);
            highlightBorder.blend = _loc2_;
         };
         var onTimerComplete:* = function(param1:TimerEvent):void
         {
            highlightBorder.visible = false;
         };
         if(_transitionTimer != null && _transitionTimer.running)
         {
            return;
         }
         highlightBorder = getHighlightBorder(true);
         transitionDuration = 500;
         delay = 16;
         steps = transitionDuration / delay;
         minValue = 0;
         maxValue = 0.35;
         highlightBorder.visible = true;
         highlightBorder.blend = 0;
         if(_transitionTimer != null)
         {
            _transitionTimer.reset();
         }
         else
         {
            _transitionTimer = new Timer(delay,steps);
            _transitionTimer.addEventListener("timer",updateValue);
            _transitionTimer.addEventListener("timerComplete",onTimerComplete);
         }
         _transitionTimer.start();
      }
   }
}

