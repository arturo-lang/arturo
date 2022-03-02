#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import objbase
import objext
#include <uiautomation.h>
#include <uiautomationcore.h>
#include <uiautomationclient.h>
#include <uiautomationcoreapi.h>
type
  NavigateDirection* = int32
  ProviderOptions* = int32
  StructureChangeType* = int32
  TextEditChangeType* = int32
  OrientationType* = int32
  DockPosition* = int32
  ExpandCollapseState* = int32
  ScrollAmount* = int32
  RowOrColumnMajor* = int32
  ToggleState* = int32
  WindowVisualState* = int32
  SynchronizedInputType* = int32
  WindowInteractionState* = int32
  SayAsInterpretAs* = int32
  TextUnit* = int32
  TextPatternRangeEndpoint* = int32
  SupportedTextSelection* = int32
  LiveSetting* = int32
  ActiveEnd* = int32
  CaretPosition* = int32
  CaretBidiMode* = int32
  ZoomUnit* = int32
  AnimationStyle* = int32
  BulletStyle* = int32
  CapStyle* = int32
  FlowDirections* = int32
  HorizontalTextAlignment* = int32
  OutlineStyles* = int32
  TextDecorationLineStyle* = int32
  VisualEffects* = int32
  NotificationProcessing* = int32
  NotificationKind* = int32
  PROPERTYID* = int32
  PATTERNID* = int32
  EVENTID* = int32
  TEXTATTRIBUTEID* = int32
  CONTROLTYPEID* = int32
  LANDMARKTYPEID* = int32
  METADATAID* = int32
  HEADINGLEVELID* = int32
  UIAutomationType* = int32
  TreeScope* = int32
  PropertyConditionFlags* = int32
  AutomationElementMode* = int32
  TreeTraversalOptions* = int32
  ConnectionRecoveryBehaviorOptions* = int32
  CoalesceEventsOptions* = int32
  UIA_HWND* = pointer
  NormalizeState* = int32
  ProviderType* = int32
  AutomationIdentifierType* = int32
  EventArgsType* = int32
  AsyncContentLoadedState* = int32
  HUIANODE* = HANDLE
  HUIAPATTERNOBJECT* = HANDLE
  HUIATEXTRANGE* = HANDLE
  HUIAEVENT* = HANDLE
const
  REQUIRED_RPCSAL_H_VERSION* = 100
  NavigateDirection_Parent* = 0
  NavigateDirection_NextSibling* = 1
  NavigateDirection_PreviousSibling* = 2
  NavigateDirection_FirstChild* = 3
  NavigateDirection_LastChild* = 4
  ProviderOptions_ClientSideProvider* = 0x1
  ProviderOptions_ServerSideProvider* = 0x2
  ProviderOptions_NonClientAreaProvider* = 0x4
  ProviderOptions_OverrideProvider* = 0x8
  ProviderOptions_ProviderOwnsSetFocus* = 0x10
  ProviderOptions_UseComThreading* = 0x20
  ProviderOptions_RefuseNonClientSupport* = 0x40
  ProviderOptions_HasNativeIAccessible* = 0x80
  ProviderOptions_UseClientCoordinates* = 0x100
  StructureChangeType_ChildAdded* = 0
  StructureChangeType_ChildRemoved* = StructureChangeType_ChildAdded+1
  StructureChangeType_ChildrenInvalidated* = StructureChangeType_ChildRemoved+1
  StructureChangeType_ChildrenBulkAdded* = StructureChangeType_ChildrenInvalidated+1
  StructureChangeType_ChildrenBulkRemoved* = StructureChangeType_ChildrenBulkAdded+1
  StructureChangeType_ChildrenReordered* = StructureChangeType_ChildrenBulkRemoved+1
  TextEditChangeType_None* = 0
  TextEditChangeType_AutoCorrect* = 1
  TextEditChangeType_Composition* = 2
  TextEditChangeType_CompositionFinalized* = 3
  TextEditChangeType_AutoComplete* = 4
  OrientationType_None* = 0
  OrientationType_Horizontal* = 1
  OrientationType_Vertical* = 2
  DockPosition_Top* = 0
  DockPosition_Left* = 1
  DockPosition_Bottom* = 2
  DockPosition_Right* = 3
  DockPosition_Fill* = 4
  DockPosition_None* = 5
  ExpandCollapseState_Collapsed* = 0
  ExpandCollapseState_Expanded* = 1
  ExpandCollapseState_PartiallyExpanded* = 2
  ExpandCollapseState_LeafNode* = 3
  ScrollAmount_LargeDecrement* = 0
  ScrollAmount_SmallDecrement* = 1
  ScrollAmount_NoAmount* = 2
  ScrollAmount_LargeIncrement* = 3
  ScrollAmount_SmallIncrement* = 4
  RowOrColumnMajor_RowMajor* = 0
  RowOrColumnMajor_ColumnMajor* = 1
  RowOrColumnMajor_Indeterminate* = 2
  ToggleState_Off* = 0
  ToggleState_On* = 1
  ToggleState_Indeterminate* = 2
  WindowVisualState_Normal* = 0
  WindowVisualState_Maximized* = 1
  WindowVisualState_Minimized* = 2
  SynchronizedInputType_KeyUp* = 0x1
  SynchronizedInputType_KeyDown* = 0x2
  SynchronizedInputType_LeftMouseUp* = 0x4
  SynchronizedInputType_LeftMouseDown* = 0x8
  SynchronizedInputType_RightMouseUp* = 0x10
  SynchronizedInputType_RightMouseDown* = 0x20
  WindowInteractionState_Running* = 0
  WindowInteractionState_Closing* = 1
  WindowInteractionState_ReadyForUserInteraction* = 2
  WindowInteractionState_BlockedByModalWindow* = 3
  WindowInteractionState_NotResponding* = 4
  SayAsInterpretAs_None* = 0
  SayAsInterpretAs_Spell* = 1
  SayAsInterpretAs_Cardinal* = 2
  SayAsInterpretAs_Ordinal* = 3
  SayAsInterpretAs_Number* = 4
  SayAsInterpretAs_Date* = 5
  SayAsInterpretAs_Time* = 6
  SayAsInterpretAs_Telephone* = 7
  SayAsInterpretAs_Currency* = 8
  SayAsInterpretAs_Net* = 9
  SayAsInterpretAs_Url* = 10
  SayAsInterpretAs_Address* = 11
  SayAsInterpretAs_Alphanumeric* = 12
  SayAsInterpretAs_Name* = 13
  SayAsInterpretAs_Media* = 14
  SayAsInterpretAs_Date_MonthDayYear* = 15
  SayAsInterpretAs_Date_DayMonthYear* = 16
  SayAsInterpretAs_Date_YearMonthDay* = 17
  SayAsInterpretAs_Date_YearMonth* = 18
  SayAsInterpretAs_Date_MonthYear* = 19
  SayAsInterpretAs_Date_DayMonth* = 20
  SayAsInterpretAs_Date_MonthDay* = 21
  SayAsInterpretAs_Date_Year* = 22
  SayAsInterpretAs_Time_HoursMinutesSeconds12* = 23
  SayAsInterpretAs_Time_HoursMinutes12* = 24
  SayAsInterpretAs_Time_HoursMinutesSeconds24* = 25
  SayAsInterpretAs_Time_HoursMinutes24* = 26
  TextUnit_Character* = 0
  TextUnit_Format* = 1
  TextUnit_Word* = 2
  TextUnit_Line* = 3
  TextUnit_Paragraph* = 4
  TextUnit_Page* = 5
  TextUnit_Document* = 6
  TextPatternRangeEndpoint_Start* = 0
  TextPatternRangeEndpoint_End* = 1
  SupportedTextSelection_None* = 0
  SupportedTextSelection_Single* = 1
  SupportedTextSelection_Multiple* = 2
  polite* = 1
  assertive* = 2
  ActiveEnd_None* = 0
  ActiveEnd_Start* = 1
  ActiveEnd_End* = 2
  CaretPosition_Unknown* = 0
  CaretPosition_EndOfLine* = 1
  CaretPosition_BeginningOfLine* = 2
  CaretBidiMode_LTR* = 0
  CaretBidiMode_RTL* = 1
  ZoomUnit_NoAmount* = 0
  ZoomUnit_LargeDecrement* = 1
  ZoomUnit_SmallDecrement* = 2
  ZoomUnit_LargeIncrement* = 3
  ZoomUnit_SmallIncrement* = 4
  AnimationStyle_None* = 0
  AnimationStyle_LasVegasLights* = 1
  AnimationStyle_BlinkingBackground* = 2
  AnimationStyle_SparkleText* = 3
  AnimationStyle_MarchingBlackAnts* = 4
  AnimationStyle_MarchingRedAnts* = 5
  AnimationStyle_Shimmer* = 6
  AnimationStyle_Other* = -1
  BulletStyle_None* = 0
  BulletStyle_HollowRoundBullet* = 1
  BulletStyle_FilledRoundBullet* = 2
  BulletStyle_HollowSquareBullet* = 3
  BulletStyle_FilledSquareBullet* = 4
  BulletStyle_DashBullet* = 5
  BulletStyle_Other* = -1
  CapStyle_None* = 0
  CapStyle_SmallCap* = 1
  CapStyle_AllCap* = 2
  CapStyle_AllPetiteCaps* = 3
  CapStyle_PetiteCaps* = 4
  CapStyle_Unicase* = 5
  CapStyle_Titling* = 6
  CapStyle_Other* = -1
  FillType_None* = 0
  FillType_Color* = 1
  FillType_Gradient* = 2
  FillType_Picture* = 3
  FillType_Pattern* = 4
  FlowDirections_Default* = 0
  FlowDirections_RightToLeft* = 0x1
  FlowDirections_BottomToTop* = 0x2
  FlowDirections_Vertical* = 0x4
  HorizontalTextAlignment_Left* = 0
  HorizontalTextAlignment_Centered* = 1
  HorizontalTextAlignment_Right* = 2
  HorizontalTextAlignment_Justified* = 3
  OutlineStyles_None* = 0
  OutlineStyles_Outline* = 1
  OutlineStyles_Shadow* = 2
  OutlineStyles_Engraved* = 4
  OutlineStyles_Embossed* = 8
  TextDecorationLineStyle_None* = 0
  TextDecorationLineStyle_Single* = 1
  TextDecorationLineStyle_WordsOnly* = 2
  TextDecorationLineStyle_Double* = 3
  TextDecorationLineStyle_Dot* = 4
  TextDecorationLineStyle_Dash* = 5
  TextDecorationLineStyle_DashDot* = 6
  TextDecorationLineStyle_DashDotDot* = 7
  TextDecorationLineStyle_Wavy* = 8
  TextDecorationLineStyle_ThickSingle* = 9
  TextDecorationLineStyle_DoubleWavy* = 11
  TextDecorationLineStyle_ThickWavy* = 12
  TextDecorationLineStyle_LongDash* = 13
  TextDecorationLineStyle_ThickDash* = 14
  TextDecorationLineStyle_ThickDashDot* = 15
  TextDecorationLineStyle_ThickDashDotDot* = 16
  TextDecorationLineStyle_ThickDot* = 17
  TextDecorationLineStyle_ThickLongDash* = 18
  TextDecorationLineStyle_Other* = -1
  VisualEffects_None* = 0
  VisualEffects_Shadow* = 1 shl 0
  VisualEffects_Reflection* = 1 shl 1
  VisualEffects_Glow* = 1 shl 2
  VisualEffects_SoftEdges* = 1 shl 3
  VisualEffects_Bevel* = 1 shl 4
  NotificationProcessing_ImportantAll* = 0
  NotificationProcessing_ImportantMostRecent* = 1
  NotificationProcessing_All* = 2
  NotificationProcessing_MostRecent* = 3
  NotificationProcessing_CurrentThenMostRecent* = 4
  NotificationKind_ItemAdded* = 0
  NotificationKind_ItemRemoved* = 1
  NotificationKind_ActionCompleted* = 2
  NotificationKind_ActionAborted* = 3
  NotificationKind_Other* = 4
  UIAutomationType_Int* = 0x1
  UIAutomationType_Bool* = 0x2
  UIAutomationType_String* = 0x3
  UIAutomationType_Double* = 0x4
  UIAutomationType_Point* = 0x5
  UIAutomationType_Rect* = 0x6
  UIAutomationType_Element* = 0x7
  UIAutomationType_Array* = 0x10000
  UIAutomationType_Out* = 0x20000
  UIAutomationType_IntArray* = UIAutomationType_Int or UIAutomationType_Array
  UIAutomationType_BoolArray* = UIAutomationType_Bool or UIAutomationType_Array
  UIAutomationType_StringArray* = UIAutomationType_String or UIAutomationType_Array
  UIAutomationType_DoubleArray* = UIAutomationType_Double or UIAutomationType_Array
  UIAutomationType_PointArray* = UIAutomationType_Point or UIAutomationType_Array
  UIAutomationType_RectArray* = UIAutomationType_Rect or UIAutomationType_Array
  UIAutomationType_ElementArray* = UIAutomationType_Element or UIAutomationType_Array
  UIAutomationType_OutInt* = UIAutomationType_Int or UIAutomationType_Out
  UIAutomationType_OutBool* = UIAutomationType_Bool or UIAutomationType_Out
  UIAutomationType_OutString* = UIAutomationType_String or UIAutomationType_Out
  UIAutomationType_OutDouble* = UIAutomationType_Double or UIAutomationType_Out
  UIAutomationType_OutPoint* = UIAutomationType_Point or UIAutomationType_Out
  UIAutomationType_OutRect* = UIAutomationType_Rect or UIAutomationType_Out
  UIAutomationType_OutElement* = UIAutomationType_Element or UIAutomationType_Out
  UIAutomationType_OutIntArray* = ( UIAutomationType_Int or UIAutomationType_Array ) or UIAutomationType_Out
  UIAutomationType_OutBoolArray* = ( UIAutomationType_Bool or UIAutomationType_Array ) or UIAutomationType_Out
  UIAutomationType_OutStringArray* = ( UIAutomationType_String or UIAutomationType_Array ) or UIAutomationType_Out
  UIAutomationType_OutDoubleArray* = ( UIAutomationType_Double or UIAutomationType_Array ) or UIAutomationType_Out
  UIAutomationType_OutPointArray* = ( UIAutomationType_Point or UIAutomationType_Array ) or UIAutomationType_Out
  UIAutomationType_OutRectArray* = ( UIAutomationType_Rect or UIAutomationType_Array ) or UIAutomationType_Out
  UIAutomationType_OutElementArray* = ( UIAutomationType_Element or UIAutomationType_Array ) or UIAutomationType_Out
  UIA_ScrollPatternNoScroll* = -1
  IID_IRawElementProviderSimple* = DEFINE_GUID("d6dd68d1-86fd-4332-8666-9abedea2d24c")
  IID_IAccessibleEx* = DEFINE_GUID("f8b80ada-2c44-48d0-89be-5ff23c9cd875")
  IID_IRawElementProviderSimple2* = DEFINE_GUID("a0a839a9-8da1-4a82-806a-8e0d44e79f56")
  IID_IRawElementProviderSimple3* = DEFINE_GUID("fcf5d820-d7ec-4613-bdf6-42a84ce7daaf")
  IID_IRawElementProviderFragmentRoot* = DEFINE_GUID("620ce2a5-ab8f-40a9-86cb-de3c75599b58")
  IID_IRawElementProviderFragment* = DEFINE_GUID("f7063da8-8359-439c-9297-bbc5299a7d87")
  IID_IRawElementProviderAdviseEvents* = DEFINE_GUID("a407b27b-0f6d-4427-9292-473c7bf93258")
  IID_IRawElementProviderHwndOverride* = DEFINE_GUID("1d5df27c-8947-4425-b8d9-79787bb460b8")
  IID_IProxyProviderWinEventSink* = DEFINE_GUID("4fd82b78-a43e-46ac-9803-0a6969c7c183")
  IID_IProxyProviderWinEventHandler* = DEFINE_GUID("89592ad4-f4e0-43d5-a3b6-bad7e111b435")
  IID_IRawElementProviderWindowlessSite* = DEFINE_GUID("0a2a93cc-bfad-42ac-9b2e-0991fb0d3ea0")
  IID_IAccessibleHostingElementProviders* = DEFINE_GUID("33ac331b-943e-4020-b295-db37784974a3")
  IID_IRawElementProviderHostingAccessibles* = DEFINE_GUID("24be0b07-d37d-487a-98cf-a13ed465e9b3")
  IID_IDockProvider* = DEFINE_GUID("159bc72c-4ad3-485e-9637-d7052edf0146")
  IID_IExpandCollapseProvider* = DEFINE_GUID("d847d3a5-cab0-4a98-8c32-ecb45c59ad24")
  IID_IGridProvider* = DEFINE_GUID("b17d6187-0907-464b-a168-0ef17a1572b1")
  IID_IGridItemProvider* = DEFINE_GUID("d02541f1-fb81-4d64-ae32-f520f8a6dbd1")
  IID_IInvokeProvider* = DEFINE_GUID("54fcb24b-e18e-47a2-b4d3-eccbe77599a2")
  IID_IMultipleViewProvider* = DEFINE_GUID("6278cab1-b556-4a1a-b4e0-418acc523201")
  IID_IRangeValueProvider* = DEFINE_GUID("36dc7aef-33e6-4691-afe1-2be7274b3d33")
  IID_IScrollItemProvider* = DEFINE_GUID("2360c714-4bf1-4b26-ba65-9b21316127eb")
  IID_ISelectionProvider* = DEFINE_GUID("fb8b03af-3bdf-48d4-bd36-1a65793be168")
  IID_ISelectionProvider2* = DEFINE_GUID("14f68475-ee1c-44f6-a869-d239381f0fe7")
  IID_IScrollProvider* = DEFINE_GUID("b38b8077-1fc3-42a5-8cae-d40c2215055a")
  IID_ISelectionItemProvider* = DEFINE_GUID("2acad808-b2d4-452d-a407-91ff1ad167b2")
  IID_ISynchronizedInputProvider* = DEFINE_GUID("29db1a06-02ce-4cf7-9b42-565d4fab20ee")
  IID_ITableProvider* = DEFINE_GUID("9c860395-97b3-490a-b52a-858cc22af166")
  IID_ITableItemProvider* = DEFINE_GUID("b9734fa6-771f-4d78-9c90-2517999349cd")
  IID_IToggleProvider* = DEFINE_GUID("56d00bd0-c4f4-433c-a836-1a52a57e0892")
  IID_ITransformProvider* = DEFINE_GUID("6829ddc4-4f91-4ffa-b86f-bd3e2987cb4c")
  IID_IValueProvider* = DEFINE_GUID("c7935180-6fb3-4201-b174-7df73adbf64a")
  IID_IWindowProvider* = DEFINE_GUID("987df77b-db06-4d77-8f8a-86a9c3bb90b9")
  IID_ILegacyIAccessibleProvider* = DEFINE_GUID("e44c3566-915d-4070-99c6-047bff5a08f5")
  IID_IItemContainerProvider* = DEFINE_GUID("e747770b-39ce-4382-ab30-d8fb3f336f24")
  IID_IVirtualizedItemProvider* = DEFINE_GUID("cb98b665-2d35-4fac-ad35-f3c60d0c0b8b")
  IID_IObjectModelProvider* = DEFINE_GUID("3ad86ebd-f5ef-483d-bb18-b1042a475d64")
  IID_IAnnotationProvider* = DEFINE_GUID("f95c7e80-bd63-4601-9782-445ebff011fc")
  IID_IStylesProvider* = DEFINE_GUID("19b6b649-f5d7-4a6d-bdcb-129252be588a")
  IID_ISpreadsheetProvider* = DEFINE_GUID("6f6b5d35-5525-4f80-b758-85473832ffc7")
  IID_ISpreadsheetItemProvider* = DEFINE_GUID("eaed4660-7b3d-4879-a2e6-365ce603f3d0")
  IID_ITransformProvider2* = DEFINE_GUID("4758742f-7ac2-460c-bc48-09fc09308a93")
  IID_IDragProvider* = DEFINE_GUID("6aa7bbbb-7ff9-497d-904f-d20b897929d8")
  IID_IDropTargetProvider* = DEFINE_GUID("bae82bfd-358a-481c-85a0-d8b4d90a5d61")
  IID_ITextRangeProvider* = DEFINE_GUID("5347ad7b-c355-46f8-aff5-909033582f63")
  IID_ITextProvider* = DEFINE_GUID("3589c92c-63f3-4367-99bb-ada653b77cf2")
  IID_ITextProvider2* = DEFINE_GUID("0dc5e6ed-3e16-4bf1-8f9a-a979878bc195")
  IID_ITextEditProvider* = DEFINE_GUID("ea3605b4-3a05-400e-b5f9-4e91b40f6176")
  IID_ITextRangeProvider2* = DEFINE_GUID("9bbce42c-1921-4f18-89ca-dba1910a0386")
  IID_ITextChildProvider* = DEFINE_GUID("4c2de2b9-c88f-4f88-a111-f1d336b7d1a9")
  IID_ICustomNavigationProvider* = DEFINE_GUID("2062a28a-8c07-4b94-8e12-7037c622aeb8")
  IID_IUIAutomationPatternInstance* = DEFINE_GUID("c03a7fe4-9431-409f-bed8-ae7c2299bc8d")
  IID_IUIAutomationPatternHandler* = DEFINE_GUID("d97022f3-a947-465e-8b2a-ac4315fa54e8")
  IID_IUIAutomationRegistrar* = DEFINE_GUID("8609c4ec-4a1a-4d88-a357-5a66e060e1cf")
  CLSID_CUIAutomationRegistrar* = DEFINE_GUID("6e29fabf-9977-42d1-8d0e-ca7e61ad87e6")
  TreeScope_None* = 0
  TreeScope_Element* = 0x1
  TreeScope_Children* = 0x2
  TreeScope_Descendants* = 0x4
  TreeScope_Parent* = 0x8
  TreeScope_Ancestors* = 0x10
  TreeScope_Subtree* = ( TreeScope_Element or TreeScope_Children ) or TreeScope_Descendants
  PropertyConditionFlags_None* = 0
  PropertyConditionFlags_IgnoreCase* = 0x1
  PropertyConditionFlags_MatchSubstring* = 0x2
  AutomationElementMode_None* = 0
  AutomationElementMode_Full* = AutomationElementMode_None+1
  TreeTraversalOptions_Default* = 0
  TreeTraversalOptions_PostOrder* = 0x1
  TreeTraversalOptions_LastToFirstOrder* = 0x2
  ConnectionRecoveryBehaviorOptions_Disabled* = 0
  ConnectionRecoveryBehaviorOptions_Enabled* = 0x1
  CoalesceEventsOptions_Disabled* = 0
  CoalesceEventsOptions_Enabled* = 0x1
  UIA_InvokePatternId* = 10000
  UIA_SelectionPatternId* = 10001
  UIA_ValuePatternId* = 10002
  UIA_RangeValuePatternId* = 10003
  UIA_ScrollPatternId* = 10004
  UIA_ExpandCollapsePatternId* = 10005
  UIA_GridPatternId* = 10006
  UIA_GridItemPatternId* = 10007
  UIA_MultipleViewPatternId* = 10008
  UIA_WindowPatternId* = 10009
  UIA_SelectionItemPatternId* = 10010
  UIA_DockPatternId* = 10011
  UIA_TablePatternId* = 10012
  UIA_TableItemPatternId* = 10013
  UIA_TextPatternId* = 10014
  UIA_TogglePatternId* = 10015
  UIA_TransformPatternId* = 10016
  UIA_ScrollItemPatternId* = 10017
  UIA_LegacyIAccessiblePatternId* = 10018
  UIA_ItemContainerPatternId* = 10019
  UIA_VirtualizedItemPatternId* = 10020
  UIA_SynchronizedInputPatternId* = 10021
  UIA_ObjectModelPatternId* = 10022
  UIA_AnnotationPatternId* = 10023
  UIA_TextPattern2Id* = 10024
  UIA_StylesPatternId* = 10025
  UIA_SpreadsheetPatternId* = 10026
  UIA_SpreadsheetItemPatternId* = 10027
  UIA_TransformPattern2Id* = 10028
  UIA_TextChildPatternId* = 10029
  UIA_DragPatternId* = 10030
  UIA_DropTargetPatternId* = 10031
  UIA_TextEditPatternId* = 10032
  UIA_CustomNavigationPatternId* = 10033
  UIA_SelectionPattern2Id* = 10034
  UIA_ToolTipOpenedEventId* = 20000
  UIA_ToolTipClosedEventId* = 20001
  UIA_StructureChangedEventId* = 20002
  UIA_MenuOpenedEventId* = 20003
  UIA_AutomationPropertyChangedEventId* = 20004
  UIA_AutomationFocusChangedEventId* = 20005
  UIA_AsyncContentLoadedEventId* = 20006
  UIA_MenuClosedEventId* = 20007
  UIA_LayoutInvalidatedEventId* = 20008
  UIA_Invoke_InvokedEventId* = 20009
  UIA_SelectionItem_ElementAddedToSelectionEventId* = 20010
  UIA_SelectionItem_ElementRemovedFromSelectionEventId* = 20011
  UIA_SelectionItem_ElementSelectedEventId* = 20012
  UIA_Selection_InvalidatedEventId* = 20013
  UIA_Text_TextSelectionChangedEventId* = 20014
  UIA_Text_TextChangedEventId* = 20015
  UIA_Window_WindowOpenedEventId* = 20016
  UIA_Window_WindowClosedEventId* = 20017
  UIA_MenuModeStartEventId* = 20018
  UIA_MenuModeEndEventId* = 20019
  UIA_InputReachedTargetEventId* = 20020
  UIA_InputReachedOtherElementEventId* = 20021
  UIA_InputDiscardedEventId* = 20022
  UIA_SystemAlertEventId* = 20023
  UIA_LiveRegionChangedEventId* = 20024
  UIA_HostedFragmentRootsInvalidatedEventId* = 20025
  UIA_Drag_DragStartEventId* = 20026
  UIA_Drag_DragCancelEventId* = 20027
  UIA_Drag_DragCompleteEventId* = 20028
  UIA_DropTarget_DragEnterEventId* = 20029
  UIA_DropTarget_DragLeaveEventId* = 20030
  UIA_DropTarget_DroppedEventId* = 20031
  UIA_TextEdit_TextChangedEventId* = 20032
  UIA_TextEdit_ConversionTargetChangedEventId* = 20033
  UIA_ChangesEventId* = 20034
  UIA_NotificationEventId* = 20035
  UIA_ActiveTextPositionChangedEventId* = 20036
  UIA_RuntimeIdPropertyId* = 30000
  UIA_BoundingRectanglePropertyId* = 30001
  UIA_ProcessIdPropertyId* = 30002
  UIA_ControlTypePropertyId* = 30003
  UIA_LocalizedControlTypePropertyId* = 30004
  UIA_NamePropertyId* = 30005
  UIA_AcceleratorKeyPropertyId* = 30006
  UIA_AccessKeyPropertyId* = 30007
  UIA_HasKeyboardFocusPropertyId* = 30008
  UIA_IsKeyboardFocusablePropertyId* = 30009
  UIA_IsEnabledPropertyId* = 30010
  UIA_AutomationIdPropertyId* = 30011
  UIA_ClassNamePropertyId* = 30012
  UIA_HelpTextPropertyId* = 30013
  UIA_ClickablePointPropertyId* = 30014
  UIA_CulturePropertyId* = 30015
  UIA_IsControlElementPropertyId* = 30016
  UIA_IsContentElementPropertyId* = 30017
  UIA_LabeledByPropertyId* = 30018
  UIA_IsPasswordPropertyId* = 30019
  UIA_NativeWindowHandlePropertyId* = 30020
  UIA_ItemTypePropertyId* = 30021
  UIA_IsOffscreenPropertyId* = 30022
  UIA_OrientationPropertyId* = 30023
  UIA_FrameworkIdPropertyId* = 30024
  UIA_IsRequiredForFormPropertyId* = 30025
  UIA_ItemStatusPropertyId* = 30026
  UIA_IsDockPatternAvailablePropertyId* = 30027
  UIA_IsExpandCollapsePatternAvailablePropertyId* = 30028
  UIA_IsGridItemPatternAvailablePropertyId* = 30029
  UIA_IsGridPatternAvailablePropertyId* = 30030
  UIA_IsInvokePatternAvailablePropertyId* = 30031
  UIA_IsMultipleViewPatternAvailablePropertyId* = 30032
  UIA_IsRangeValuePatternAvailablePropertyId* = 30033
  UIA_IsScrollPatternAvailablePropertyId* = 30034
  UIA_IsScrollItemPatternAvailablePropertyId* = 30035
  UIA_IsSelectionItemPatternAvailablePropertyId* = 30036
  UIA_IsSelectionPatternAvailablePropertyId* = 30037
  UIA_IsTablePatternAvailablePropertyId* = 30038
  UIA_IsTableItemPatternAvailablePropertyId* = 30039
  UIA_IsTextPatternAvailablePropertyId* = 30040
  UIA_IsTogglePatternAvailablePropertyId* = 30041
  UIA_IsTransformPatternAvailablePropertyId* = 30042
  UIA_IsValuePatternAvailablePropertyId* = 30043
  UIA_IsWindowPatternAvailablePropertyId* = 30044
  UIA_ValueValuePropertyId* = 30045
  UIA_ValueIsReadOnlyPropertyId* = 30046
  UIA_RangeValueValuePropertyId* = 30047
  UIA_RangeValueIsReadOnlyPropertyId* = 30048
  UIA_RangeValueMinimumPropertyId* = 30049
  UIA_RangeValueMaximumPropertyId* = 30050
  UIA_RangeValueLargeChangePropertyId* = 30051
  UIA_RangeValueSmallChangePropertyId* = 30052
  UIA_ScrollHorizontalScrollPercentPropertyId* = 30053
  UIA_ScrollHorizontalViewSizePropertyId* = 30054
  UIA_ScrollVerticalScrollPercentPropertyId* = 30055
  UIA_ScrollVerticalViewSizePropertyId* = 30056
  UIA_ScrollHorizontallyScrollablePropertyId* = 30057
  UIA_ScrollVerticallyScrollablePropertyId* = 30058
  UIA_SelectionSelectionPropertyId* = 30059
  UIA_SelectionCanSelectMultiplePropertyId* = 30060
  UIA_SelectionIsSelectionRequiredPropertyId* = 30061
  UIA_GridRowCountPropertyId* = 30062
  UIA_GridColumnCountPropertyId* = 30063
  UIA_GridItemRowPropertyId* = 30064
  UIA_GridItemColumnPropertyId* = 30065
  UIA_GridItemRowSpanPropertyId* = 30066
  UIA_GridItemColumnSpanPropertyId* = 30067
  UIA_GridItemContainingGridPropertyId* = 30068
  UIA_DockDockPositionPropertyId* = 30069
  UIA_ExpandCollapseExpandCollapseStatePropertyId* = 30070
  UIA_MultipleViewCurrentViewPropertyId* = 30071
  UIA_MultipleViewSupportedViewsPropertyId* = 30072
  UIA_WindowCanMaximizePropertyId* = 30073
  UIA_WindowCanMinimizePropertyId* = 30074
  UIA_WindowWindowVisualStatePropertyId* = 30075
  UIA_WindowWindowInteractionStatePropertyId* = 30076
  UIA_WindowIsModalPropertyId* = 30077
  UIA_WindowIsTopmostPropertyId* = 30078
  UIA_SelectionItemIsSelectedPropertyId* = 30079
  UIA_SelectionItemSelectionContainerPropertyId* = 30080
  UIA_TableRowHeadersPropertyId* = 30081
  UIA_TableColumnHeadersPropertyId* = 30082
  UIA_TableRowOrColumnMajorPropertyId* = 30083
  UIA_TableItemRowHeaderItemsPropertyId* = 30084
  UIA_TableItemColumnHeaderItemsPropertyId* = 30085
  UIA_ToggleToggleStatePropertyId* = 30086
  UIA_TransformCanMovePropertyId* = 30087
  UIA_TransformCanResizePropertyId* = 30088
  UIA_TransformCanRotatePropertyId* = 30089
  UIA_IsLegacyIAccessiblePatternAvailablePropertyId* = 30090
  UIA_LegacyIAccessibleChildIdPropertyId* = 30091
  UIA_LegacyIAccessibleNamePropertyId* = 30092
  UIA_LegacyIAccessibleValuePropertyId* = 30093
  UIA_LegacyIAccessibleDescriptionPropertyId* = 30094
  UIA_LegacyIAccessibleRolePropertyId* = 30095
  UIA_LegacyIAccessibleStatePropertyId* = 30096
  UIA_LegacyIAccessibleHelpPropertyId* = 30097
  UIA_LegacyIAccessibleKeyboardShortcutPropertyId* = 30098
  UIA_LegacyIAccessibleSelectionPropertyId* = 30099
  UIA_LegacyIAccessibleDefaultActionPropertyId* = 30100
  UIA_AriaRolePropertyId* = 30101
  UIA_AriaPropertiesPropertyId* = 30102
  UIA_IsDataValidForFormPropertyId* = 30103
  UIA_ControllerForPropertyId* = 30104
  UIA_DescribedByPropertyId* = 30105
  UIA_FlowsToPropertyId* = 30106
  UIA_ProviderDescriptionPropertyId* = 30107
  UIA_IsItemContainerPatternAvailablePropertyId* = 30108
  UIA_IsVirtualizedItemPatternAvailablePropertyId* = 30109
  UIA_IsSynchronizedInputPatternAvailablePropertyId* = 30110
  UIA_OptimizeForVisualContentPropertyId* = 30111
  UIA_IsObjectModelPatternAvailablePropertyId* = 30112
  UIA_AnnotationAnnotationTypeIdPropertyId* = 30113
  UIA_AnnotationAnnotationTypeNamePropertyId* = 30114
  UIA_AnnotationAuthorPropertyId* = 30115
  UIA_AnnotationDateTimePropertyId* = 30116
  UIA_AnnotationTargetPropertyId* = 30117
  UIA_IsAnnotationPatternAvailablePropertyId* = 30118
  UIA_IsTextPattern2AvailablePropertyId* = 30119
  UIA_StylesStyleIdPropertyId* = 30120
  UIA_StylesStyleNamePropertyId* = 30121
  UIA_StylesFillColorPropertyId* = 30122
  UIA_StylesFillPatternStylePropertyId* = 30123
  UIA_StylesShapePropertyId* = 30124
  UIA_StylesFillPatternColorPropertyId* = 30125
  UIA_StylesExtendedPropertiesPropertyId* = 30126
  UIA_IsStylesPatternAvailablePropertyId* = 30127
  UIA_IsSpreadsheetPatternAvailablePropertyId* = 30128
  UIA_SpreadsheetItemFormulaPropertyId* = 30129
  UIA_SpreadsheetItemAnnotationObjectsPropertyId* = 30130
  UIA_SpreadsheetItemAnnotationTypesPropertyId* = 30131
  UIA_IsSpreadsheetItemPatternAvailablePropertyId* = 30132
  UIA_Transform2CanZoomPropertyId* = 30133
  UIA_IsTransformPattern2AvailablePropertyId* = 30134
  UIA_LiveSettingPropertyId* = 30135
  UIA_IsTextChildPatternAvailablePropertyId* = 30136
  UIA_IsDragPatternAvailablePropertyId* = 30137
  UIA_DragIsGrabbedPropertyId* = 30138
  UIA_DragDropEffectPropertyId* = 30139
  UIA_DragDropEffectsPropertyId* = 30140
  UIA_IsDropTargetPatternAvailablePropertyId* = 30141
  UIA_DropTargetDropTargetEffectPropertyId* = 30142
  UIA_DropTargetDropTargetEffectsPropertyId* = 30143
  UIA_DragGrabbedItemsPropertyId* = 30144
  UIA_Transform2ZoomLevelPropertyId* = 30145
  UIA_Transform2ZoomMinimumPropertyId* = 30146
  UIA_Transform2ZoomMaximumPropertyId* = 30147
  UIA_FlowsFromPropertyId* = 30148
  UIA_IsTextEditPatternAvailablePropertyId* = 30149
  UIA_IsPeripheralPropertyId* = 30150
  UIA_IsCustomNavigationPatternAvailablePropertyId* = 30151
  UIA_PositionInSetPropertyId* = 30152
  UIA_SizeOfSetPropertyId* = 30153
  UIA_LevelPropertyId* = 30154
  UIA_AnnotationTypesPropertyId* = 30155
  UIA_AnnotationObjectsPropertyId* = 30156
  UIA_LandmarkTypePropertyId* = 30157
  UIA_LocalizedLandmarkTypePropertyId* = 30158
  UIA_FullDescriptionPropertyId* = 30159
  UIA_FillColorPropertyId* = 30160
  UIA_OutlineColorPropertyId* = 30161
  UIA_FillTypePropertyId* = 30162
  UIA_VisualEffectsPropertyId* = 30163
  UIA_OutlineThicknessPropertyId* = 30164
  UIA_CenterPointPropertyId* = 30165
  UIA_RotationPropertyId* = 30166
  UIA_SizePropertyId* = 30167
  UIA_IsSelectionPattern2AvailablePropertyId* = 30168
  UIA_Selection2FirstSelectedItemPropertyId* = 30169
  UIA_Selection2LastSelectedItemPropertyId* = 30170
  UIA_Selection2CurrentSelectedItemPropertyId* = 30171
  UIA_Selection2ItemCountPropertyId* = 30172
  UIA_HeadingLevelPropertyId* = 30173
  UIA_IsDialogPropertyId* = 30174
  UIA_AnimationStyleAttributeId* = 40000
  UIA_BackgroundColorAttributeId* = 40001
  UIA_BulletStyleAttributeId* = 40002
  UIA_CapStyleAttributeId* = 40003
  UIA_CultureAttributeId* = 40004
  UIA_FontNameAttributeId* = 40005
  UIA_FontSizeAttributeId* = 40006
  UIA_FontWeightAttributeId* = 40007
  UIA_ForegroundColorAttributeId* = 40008
  UIA_HorizontalTextAlignmentAttributeId* = 40009
  UIA_IndentationFirstLineAttributeId* = 40010
  UIA_IndentationLeadingAttributeId* = 40011
  UIA_IndentationTrailingAttributeId* = 40012
  UIA_IsHiddenAttributeId* = 40013
  UIA_IsItalicAttributeId* = 40014
  UIA_IsReadOnlyAttributeId* = 40015
  UIA_IsSubscriptAttributeId* = 40016
  UIA_IsSuperscriptAttributeId* = 40017
  UIA_MarginBottomAttributeId* = 40018
  UIA_MarginLeadingAttributeId* = 40019
  UIA_MarginTopAttributeId* = 40020
  UIA_MarginTrailingAttributeId* = 40021
  UIA_OutlineStylesAttributeId* = 40022
  UIA_OverlineColorAttributeId* = 40023
  UIA_OverlineStyleAttributeId* = 40024
  UIA_StrikethroughColorAttributeId* = 40025
  UIA_StrikethroughStyleAttributeId* = 40026
  UIA_TabsAttributeId* = 40027
  UIA_TextFlowDirectionsAttributeId* = 40028
  UIA_UnderlineColorAttributeId* = 40029
  UIA_UnderlineStyleAttributeId* = 40030
  UIA_AnnotationTypesAttributeId* = 40031
  UIA_AnnotationObjectsAttributeId* = 40032
  UIA_StyleNameAttributeId* = 40033
  UIA_StyleIdAttributeId* = 40034
  UIA_LinkAttributeId* = 40035
  UIA_IsActiveAttributeId* = 40036
  UIA_SelectionActiveEndAttributeId* = 40037
  UIA_CaretPositionAttributeId* = 40038
  UIA_CaretBidiModeAttributeId* = 40039
  UIA_LineSpacingAttributeId* = 40040
  UIA_BeforeParagraphSpacingAttributeId* = 40041
  UIA_AfterParagraphSpacingAttributeId* = 40042
  UIA_SayAsInterpretAsAttributeId* = 40043
  UIA_ButtonControlTypeId* = 50000
  UIA_CalendarControlTypeId* = 50001
  UIA_CheckBoxControlTypeId* = 50002
  UIA_ComboBoxControlTypeId* = 50003
  UIA_EditControlTypeId* = 50004
  UIA_HyperlinkControlTypeId* = 50005
  UIA_ImageControlTypeId* = 50006
  UIA_ListItemControlTypeId* = 50007
  UIA_ListControlTypeId* = 50008
  UIA_MenuControlTypeId* = 50009
  UIA_MenuBarControlTypeId* = 50010
  UIA_MenuItemControlTypeId* = 50011
  UIA_ProgressBarControlTypeId* = 50012
  UIA_RadioButtonControlTypeId* = 50013
  UIA_ScrollBarControlTypeId* = 50014
  UIA_SliderControlTypeId* = 50015
  UIA_SpinnerControlTypeId* = 50016
  UIA_StatusBarControlTypeId* = 50017
  UIA_TabControlTypeId* = 50018
  UIA_TabItemControlTypeId* = 50019
  UIA_TextControlTypeId* = 50020
  UIA_ToolBarControlTypeId* = 50021
  UIA_ToolTipControlTypeId* = 50022
  UIA_TreeControlTypeId* = 50023
  UIA_TreeItemControlTypeId* = 50024
  UIA_CustomControlTypeId* = 50025
  UIA_GroupControlTypeId* = 50026
  UIA_ThumbControlTypeId* = 50027
  UIA_DataGridControlTypeId* = 50028
  UIA_DataItemControlTypeId* = 50029
  UIA_DocumentControlTypeId* = 50030
  UIA_SplitButtonControlTypeId* = 50031
  UIA_WindowControlTypeId* = 50032
  UIA_PaneControlTypeId* = 50033
  UIA_HeaderControlTypeId* = 50034
  UIA_HeaderItemControlTypeId* = 50035
  UIA_TableControlTypeId* = 50036
  UIA_TitleBarControlTypeId* = 50037
  UIA_SeparatorControlTypeId* = 50038
  UIA_SemanticZoomControlTypeId* = 50039
  UIA_AppBarControlTypeId* = 50040
  AnnotationType_Unknown* = 60000
  AnnotationType_SpellingError* = 60001
  AnnotationType_GrammarError* = 60002
  AnnotationType_Comment* = 60003
  AnnotationType_FormulaError* = 60004
  AnnotationType_TrackChanges* = 60005
  AnnotationType_Header* = 60006
  AnnotationType_Footer* = 60007
  AnnotationType_Highlighted* = 60008
  AnnotationType_Endnote* = 60009
  AnnotationType_Footnote* = 60010
  AnnotationType_InsertionChange* = 60011
  AnnotationType_DeletionChange* = 60012
  AnnotationType_MoveChange* = 60013
  AnnotationType_FormatChange* = 60014
  AnnotationType_UnsyncedChange* = 60015
  AnnotationType_EditingLockedChange* = 60016
  AnnotationType_ExternalChange* = 60017
  AnnotationType_ConflictingChange* = 60018
  AnnotationType_Author* = 60019
  AnnotationType_AdvancedProofingIssue* = 60020
  AnnotationType_DataValidationError* = 60021
  AnnotationType_CircularReferenceError* = 60022
  AnnotationType_Mathematics* = 60023
  StyleId_Custom* = 70000
  StyleId_Heading1* = 70001
  StyleId_Heading2* = 70002
  StyleId_Heading3* = 70003
  StyleId_Heading4* = 70004
  StyleId_Heading5* = 70005
  StyleId_Heading6* = 70006
  StyleId_Heading7* = 70007
  StyleId_Heading8* = 70008
  StyleId_Heading9* = 70009
  StyleId_Title* = 70010
  StyleId_Subtitle* = 70011
  StyleId_Normal* = 70012
  StyleId_Emphasis* = 70013
  StyleId_Quote* = 70014
  StyleId_BulletedList* = 70015
  StyleId_NumberedList* = 70016
  UIA_CustomLandmarkTypeId* = 80000
  UIA_FormLandmarkTypeId* = 80001
  UIA_MainLandmarkTypeId* = 80002
  UIA_NavigationLandmarkTypeId* = 80003
  UIA_SearchLandmarkTypeId* = 80004
  HeadingLevel_None* = 80050
  headingLevel1* = 80051
  headingLevel2* = 80052
  headingLevel3* = 80053
  headingLevel4* = 80054
  headingLevel5* = 80055
  headingLevel6* = 80056
  headingLevel7* = 80057
  headingLevel8* = 80058
  headingLevel9* = 80059
  UIA_SummaryChangeId* = 90000
  UIA_SayAsInterpretAsMetadataId* = 100000
  IID_IUIAutomationElement* = DEFINE_GUID("d22108aa-8ac5-49a5-837b-37bbb3d7591e")
  IID_IUIAutomationElementArray* = DEFINE_GUID("14314595-b4bc-4055-95f2-58f2e42c9855")
  IID_IUIAutomationCondition* = DEFINE_GUID("352ffba8-0973-437c-a61f-f64cafd81df9")
  IID_IUIAutomationBoolCondition* = DEFINE_GUID("1b4e1f2e-75eb-4d0b-8952-5a69988e2307")
  IID_IUIAutomationPropertyCondition* = DEFINE_GUID("99ebf2cb-5578-4267-9ad4-afd6ea77e94b")
  IID_IUIAutomationAndCondition* = DEFINE_GUID("a7d0af36-b912-45fe-9855-091ddc174aec")
  IID_IUIAutomationOrCondition* = DEFINE_GUID("8753f032-3db1-47b5-a1fc-6e34a266c712")
  IID_IUIAutomationNotCondition* = DEFINE_GUID("f528b657-847b-498c-8896-d52b565407a1")
  IID_IUIAutomationCacheRequest* = DEFINE_GUID("b32a92b5-bc25-4078-9c08-d7ee95c48e03")
  IID_IUIAutomationTreeWalker* = DEFINE_GUID("4042c624-389c-4afc-a630-9df854a541fc")
  IID_IUIAutomationEventHandler* = DEFINE_GUID("146c3c17-f12e-4e22-8c27-f894b9b79c69")
  IID_IUIAutomationPropertyChangedEventHandler* = DEFINE_GUID("40cd37d4-c756-4b0c-8c6f-bddfeeb13b50")
  IID_IUIAutomationStructureChangedEventHandler* = DEFINE_GUID("e81d1b4e-11c5-42f8-9754-e7036c79f054")
  IID_IUIAutomationFocusChangedEventHandler* = DEFINE_GUID("c270f6b5-5c69-4290-9745-7a7f97169468")
  IID_IUIAutomationTextEditTextChangedEventHandler* = DEFINE_GUID("92faa680-e704-4156-931a-e32d5bb38f3f")
  IID_IUIAutomationChangesEventHandler* = DEFINE_GUID("58edca55-2c3e-4980-b1b9-56c17f27a2a0")
  IID_IUIAutomationNotificationEventHandler* = DEFINE_GUID("c7cb2637-e6c2-4d0c-85de-4948c02175c7")
  IID_IUIAutomationInvokePattern* = DEFINE_GUID("fb377fbe-8ea6-46d5-9c73-6499642d3059")
  IID_IUIAutomationDockPattern* = DEFINE_GUID("fde5ef97-1464-48f6-90bf-43d0948e86ec")
  IID_IUIAutomationExpandCollapsePattern* = DEFINE_GUID("619be086-1f4e-4ee4-bafa-210128738730")
  IID_IUIAutomationGridPattern* = DEFINE_GUID("414c3cdc-856b-4f5b-8538-3131c6302550")
  IID_IUIAutomationGridItemPattern* = DEFINE_GUID("78f8ef57-66c3-4e09-bd7c-e79b2004894d")
  IID_IUIAutomationMultipleViewPattern* = DEFINE_GUID("8d253c91-1dc5-4bb5-b18f-ade16fa495e8")
  IID_IUIAutomationObjectModelPattern* = DEFINE_GUID("71c284b3-c14d-4d14-981e-19751b0d756d")
  IID_IUIAutomationRangeValuePattern* = DEFINE_GUID("59213f4f-7346-49e5-b120-80555987a148")
  IID_IUIAutomationScrollPattern* = DEFINE_GUID("88f4d42a-e881-459d-a77c-73bbbb7e02dc")
  IID_IUIAutomationScrollItemPattern* = DEFINE_GUID("b488300f-d015-4f19-9c29-bb595e3645ef")
  IID_IUIAutomationSelectionPattern* = DEFINE_GUID("5ed5202e-b2ac-47a6-b638-4b0bf140d78e")
  IID_IUIAutomationSelectionPattern2* = DEFINE_GUID("0532bfae-c011-4e32-a343-6d642d798555")
  IID_IUIAutomationSelectionItemPattern* = DEFINE_GUID("a8efa66a-0fda-421a-9194-38021f3578ea")
  IID_IUIAutomationSynchronizedInputPattern* = DEFINE_GUID("2233be0b-afb7-448b-9fda-3b378aa5eae1")
  IID_IUIAutomationTablePattern* = DEFINE_GUID("620e691c-ea96-4710-a850-754b24ce2417")
  IID_IUIAutomationTableItemPattern* = DEFINE_GUID("0b964eb3-ef2e-4464-9c79-61d61737a27e")
  IID_IUIAutomationTogglePattern* = DEFINE_GUID("94cf8058-9b8d-4ab9-8bfd-4cd0a33c8c70")
  IID_IUIAutomationTransformPattern* = DEFINE_GUID("a9b55844-a55d-4ef0-926d-569c16ff89bb")
  IID_IUIAutomationValuePattern* = DEFINE_GUID("a94cd8b1-0844-4cd6-9d2d-640537ab39e9")
  IID_IUIAutomationWindowPattern* = DEFINE_GUID("0faef453-9208-43ef-bbb2-3b485177864f")
  IID_IUIAutomationTextRange* = DEFINE_GUID("a543cc6a-f4ae-494b-8239-c814481187a8")
  IID_IUIAutomationTextRange2* = DEFINE_GUID("bb9b40e0-5e04-46bd-9be0-4b601b9afad4")
  IID_IUIAutomationTextRange3* = DEFINE_GUID("6a315d69-5512-4c2e-85f0-53fce6dd4bc2")
  IID_IUIAutomationTextRangeArray* = DEFINE_GUID("ce4ae76a-e717-4c98-81ea-47371d028eb6")
  IID_IUIAutomationTextPattern* = DEFINE_GUID("32eba289-3583-42c9-9c59-3b6d9a1e9b6a")
  IID_IUIAutomationTextPattern2* = DEFINE_GUID("506a921a-fcc9-409f-b23b-37eb74106872")
  IID_IUIAutomationTextEditPattern* = DEFINE_GUID("17e21576-996c-4870-99d9-bff323380c06")
  IID_IUIAutomationCustomNavigationPattern* = DEFINE_GUID("01ea217a-1766-47ed-a6cc-acf492854b1f")
  IID_IUIAutomationActiveTextPositionChangedEventHandler* = DEFINE_GUID("f97933b0-8dae-4496-8997-5ba015fe0d82")
  IID_IUIAutomationLegacyIAccessiblePattern* = DEFINE_GUID("828055ad-355b-4435-86d5-3b51c14a9b1b")
  IID_IUIAutomationItemContainerPattern* = DEFINE_GUID("c690fdb2-27a8-423c-812d-429773c9084e")
  IID_IUIAutomationVirtualizedItemPattern* = DEFINE_GUID("6ba3d7a6-04cf-4f11-8793-a8d1cde9969f")
  IID_IUIAutomationAnnotationPattern* = DEFINE_GUID("9a175b21-339e-41b1-8e8b-623f6b681098")
  IID_IUIAutomationStylesPattern* = DEFINE_GUID("85b5f0a2-bd79-484a-ad2b-388c9838d5fb")
  IID_IUIAutomationSpreadsheetPattern* = DEFINE_GUID("7517a7c8-faae-4de9-9f08-29b91e8595c1")
  IID_IUIAutomationSpreadsheetItemPattern* = DEFINE_GUID("7d4fb86c-8d34-40e1-8e83-62c15204e335")
  IID_IUIAutomationTransformPattern2* = DEFINE_GUID("6d74d017-6ecb-4381-b38b-3c17a48ff1c2")
  IID_IUIAutomationTextChildPattern* = DEFINE_GUID("6552b038-ae05-40c8-abfd-aa08352aab86")
  IID_IUIAutomationDragPattern* = DEFINE_GUID("1dc7b570-1f54-4bad-bcda-d36a722fb7bd")
  IID_IUIAutomationDropTargetPattern* = DEFINE_GUID("69a095f7-eee4-430e-a46b-fb73b1ae39a5")
  IID_IUIAutomationElement2* = DEFINE_GUID("6749c683-f70d-4487-a698-5f79d55290d6")
  IID_IUIAutomationElement3* = DEFINE_GUID("8471df34-aee0-4a01-a7de-7db9af12c296")
  IID_IUIAutomationElement4* = DEFINE_GUID("3b6e233c-52fb-4063-a4c9-77c075c2a06b")
  IID_IUIAutomationElement5* = DEFINE_GUID("98141c1d-0d0e-4175-bbe2-6bff455842a7")
  IID_IUIAutomationElement6* = DEFINE_GUID("4780d450-8bca-4977-afa5-a4a517f555e3")
  IID_IUIAutomationElement7* = DEFINE_GUID("204e8572-cfc3-4c11-b0c8-7da7420750b7")
  IID_IUIAutomationElement8* = DEFINE_GUID("8c60217d-5411-4cde-bcc0-1ceda223830c")
  IID_IUIAutomationElement9* = DEFINE_GUID("39325fac-039d-440e-a3a3-5eb81a5cecc3")
  IID_IUIAutomationProxyFactory* = DEFINE_GUID("85b94ecd-849d-42b6-b94d-d6db23fdf5a4")
  IID_IUIAutomationProxyFactoryEntry* = DEFINE_GUID("d50e472e-b64b-490c-bca1-d30696f9f289")
  IID_IUIAutomationProxyFactoryMapping* = DEFINE_GUID("09e31e18-872d-4873-93d1-1e541ec133fd")
  IID_IUIAutomationEventHandlerGroup* = DEFINE_GUID("c9ee12f2-c13b-4408-997c-639914377f4e")
  IID_IUIAutomation* = DEFINE_GUID("30cbe57d-d9d0-452a-ab13-7ac5ac4825ee")
  IID_IUIAutomation2* = DEFINE_GUID("34723aff-0c9d-49d0-9896-7ab52df8cd8a")
  IID_IUIAutomation3* = DEFINE_GUID("73d768da-9b51-4b89-936e-c209290973e7")
  IID_IUIAutomation4* = DEFINE_GUID("1189c02a-05f8-4319-8e21-e817e3db2860")
  IID_IUIAutomation5* = DEFINE_GUID("25f700c8-d816-4057-a9dc-3cbdee77e256")
  IID_IUIAutomation6* = DEFINE_GUID("aae072da-29e3-413d-87a7-192dbf81ed10")
  CLSID_CUIAutomation* = DEFINE_GUID("ff48dba4-60ef-4201-aa87-54103eef594e")
  CLSID_CUIAutomation8* = DEFINE_GUID("e22ad333-b25f-460c-83d0-0581107395c9")
  UIA_E_ELEMENTNOTENABLED* = 0x80040200'i32
  UIA_E_ELEMENTNOTAVAILABLE* = 0x80040201'i32
  UIA_E_NOCLICKABLEPOINT* = 0x80040202'i32
  UIA_E_PROXYASSEMBLYNOTLOADED* = 0x80040203'i32
  UIA_E_NOTSUPPORTED* = 0x80040204'i32
  UIA_E_INVALIDOPERATION* = 0x80131509'i32
  UIA_E_TIMEOUT* = 0x80131505'i32
  uiaAppendRuntimeId* = 3
  uiaRootObjectId* = -25
  RuntimeId_Property_GUID* = DEFINE_GUID("a39eebfa-7fba-4c89-b4d4-b99e2de7d160")
  BoundingRectangle_Property_GUID* = DEFINE_GUID("7bbfe8b2-3bfc-48dd-b729-c794b846e9a1")
  ProcessId_Property_GUID* = DEFINE_GUID("40499998-9c31-4245-a403-87320e59eaf6")
  ControlType_Property_GUID* = DEFINE_GUID("ca774fea-28ac-4bc2-94ca-acec6d6c10a3")
  LocalizedControlType_Property_GUID* = DEFINE_GUID("8763404f-a1bd-452a-89c4-3f01d3833806")
  Name_Property_GUID* = DEFINE_GUID("c3a6921b-4a99-44f1-bca6-61187052c431")
  AcceleratorKey_Property_GUID* = DEFINE_GUID("514865df-2557-4cb9-aeed-6ced084ce52c")
  AccessKey_Property_GUID* = DEFINE_GUID("06827b12-a7f9-4a15-917c-ffa5ad3eb0a7")
  HasKeyboardFocus_Property_GUID* = DEFINE_GUID("cf8afd39-3f46-4800-9656-b2bf12529905")
  IsKeyboardFocusable_Property_GUID* = DEFINE_GUID("f7b8552a-0859-4b37-b9cb-51e72092f29f")
  IsEnabled_Property_GUID* = DEFINE_GUID("2109427f-da60-4fed-bf1b-264bdce6eb3a")
  AutomationId_Property_GUID* = DEFINE_GUID("c82c0500-b60e-4310-a267-303c531f8ee5")
  ClassName_Property_GUID* = DEFINE_GUID("157b7215-894f-4b65-84e2-aac0da08b16b")
  HelpText_Property_GUID* = DEFINE_GUID("08555685-0977-45c7-a7a6-abaf5684121a")
  ClickablePoint_Property_GUID* = DEFINE_GUID("0196903b-b203-4818-a9f3-f08e675f2341")
  Culture_Property_GUID* = DEFINE_GUID("e2d74f27-3d79-4dc2-b88b-3044963a8afb")
  IsControlElement_Property_GUID* = DEFINE_GUID("95f35085-abcc-4afd-a5f4-dbb46c230fdb")
  IsContentElement_Property_GUID* = DEFINE_GUID("4bda64a8-f5d8-480b-8155-ef2e89adb672")
  LabeledBy_Property_GUID* = DEFINE_GUID("e5b8924b-fc8a-4a35-8031-cf78ac43e55e")
  IsPassword_Property_GUID* = DEFINE_GUID("e8482eb1-687c-497b-bebc-03be53ec1454")
  NewNativeWindowHandle_Property_GUID* = DEFINE_GUID("5196b33b-380a-4982-95e1-91f3ef60e024")
  ItemType_Property_GUID* = DEFINE_GUID("cdda434d-6222-413b-a68a-325dd1d40f39")
  IsOffscreen_Property_GUID* = DEFINE_GUID("03c3d160-db79-42db-a2ef-1c231eede507")
  Orientation_Property_GUID* = DEFINE_GUID("a01eee62-3884-4415-887e-678ec21e39ba")
  FrameworkId_Property_GUID* = DEFINE_GUID("dbfd9900-7e1a-4f58-b61b-7063120f773b")
  IsRequiredForForm_Property_GUID* = DEFINE_GUID("4f5f43cf-59fb-4bde-a270-602e5e1141e9")
  ItemStatus_Property_GUID* = DEFINE_GUID("51de0321-3973-43e7-8913-0b08e813c37f")
  AriaRole_Property_GUID* = DEFINE_GUID("dd207b95-be4a-4e0d-b727-63ace94b6916")
  AriaProperties_Property_GUID* = DEFINE_GUID("4213678c-e025-4922-beb5-e43ba08e6221")
  IsDataValidForForm_Property_GUID* = DEFINE_GUID("445ac684-c3fc-4dd9-acf8-845a579296ba")
  ControllerFor_Property_GUID* = DEFINE_GUID("51124c8a-a5d2-4f13-9be6-7fa8ba9d3a90")
  DescribedBy_Property_GUID* = DEFINE_GUID("7c5865b8-9992-40fd-8db0-6bf1d317f998")
  FlowsTo_Property_GUID* = DEFINE_GUID("e4f33d20-559a-47fb-a830-f9cb4ff1a70a")
  ProviderDescription_Property_GUID* = DEFINE_GUID("dca5708a-c16b-4cd9-b889-beb16a804904")
  OptimizeForVisualContent_Property_GUID* = DEFINE_GUID("6a852250-c75a-4e5d-b858-e381b0f78861")
  IsDockPatternAvailable_Property_GUID* = DEFINE_GUID("2600a4c4-2ff8-4c96-ae31-8fe619a13c6c")
  IsExpandCollapsePatternAvailable_Property_GUID* = DEFINE_GUID("929d3806-5287-4725-aa16-222afc63d595")
  IsGridItemPatternAvailable_Property_GUID* = DEFINE_GUID("5a43e524-f9a2-4b12-84c8-b48a3efedd34")
  IsGridPatternAvailable_Property_GUID* = DEFINE_GUID("5622c26c-f0ef-4f3b-97cb-714c0868588b")
  IsInvokePatternAvailable_Property_GUID* = DEFINE_GUID("4e725738-8364-4679-aa6c-f3f41931f750")
  IsMultipleViewPatternAvailable_Property_GUID* = DEFINE_GUID("ff0a31eb-8e25-469d-8d6e-e771a27c1b90")
  IsRangeValuePatternAvailable_Property_GUID* = DEFINE_GUID("fda4244a-eb4d-43ff-b5ad-ed36d373ec4c")
  IsScrollPatternAvailable_Property_GUID* = DEFINE_GUID("3ebb7b4a-828a-4b57-9d22-2fea1632ed0d")
  IsScrollItemPatternAvailable_Property_GUID* = DEFINE_GUID("1cad1a05-0927-4b76-97e1-0fcdb209b98a")
  IsSelectionItemPatternAvailable_Property_GUID* = DEFINE_GUID("8becd62d-0bc3-4109-bee2-8e6715290e68")
  IsSelectionPatternAvailable_Property_GUID* = DEFINE_GUID("f588acbe-c769-4838-9a60-2686dc1188c4")
  IsTablePatternAvailable_Property_GUID* = DEFINE_GUID("cb83575f-45c2-4048-9c76-159715a139df")
  IsTableItemPatternAvailable_Property_GUID* = DEFINE_GUID("eb36b40d-8ea4-489b-a013-e60d5951fe34")
  IsTextPatternAvailable_Property_GUID* = DEFINE_GUID("fbe2d69d-aff6-4a45-82e2-fc92a82f5917")
  IsTogglePatternAvailable_Property_GUID* = DEFINE_GUID("78686d53-fcd0-4b83-9b78-5832ce63bb5b")
  IsTransformPatternAvailable_Property_GUID* = DEFINE_GUID("a7f78804-d68b-4077-a5c6-7a5ea1ac31c5")
  IsValuePatternAvailable_Property_GUID* = DEFINE_GUID("0b5020a7-2119-473b-be37-5ceb98bbfb22")
  IsWindowPatternAvailable_Property_GUID* = DEFINE_GUID("e7a57bb1-5888-4155-98dc-b422fd57f2bc")
  IsLegacyIAccessiblePatternAvailable_Property_GUID* = DEFINE_GUID("d8ebd0c7-929a-4ee7-8d3a-d3d94413027b")
  IsItemContainerPatternAvailable_Property_GUID* = DEFINE_GUID("624b5ca7-fe40-4957-a019-20c4cf11920f")
  IsVirtualizedItemPatternAvailable_Property_GUID* = DEFINE_GUID("302cb151-2ac8-45d6-977b-d2b3a5a53f20")
  IsSynchronizedInputPatternAvailable_Property_GUID* = DEFINE_GUID("75d69cc5-d2bf-4943-876e-b45b62a6cc66")
  IsObjectModelPatternAvailable_Property_GUID* = DEFINE_GUID("6b21d89b-2841-412f-8ef2-15ca952318ba")
  IsAnnotationPatternAvailable_Property_GUID* = DEFINE_GUID("0b5b3238-6d5c-41b6-bcc4-5e807f6551c4")
  IsTextPattern2Available_Property_GUID* = DEFINE_GUID("41cf921d-e3f1-4b22-9c81-e1c3ed331c22")
  IsTextEditPatternAvailable_Property_GUID* = DEFINE_GUID("7843425c-8b32-484c-9ab5-e3200571ffda")
  IsCustomNavigationPatternAvailable_Property_GUID* = DEFINE_GUID("8f8e80d4-2351-48e0-874a-54aa7313889a")
  IsStylesPatternAvailable_Property_GUID* = DEFINE_GUID("27f353d3-459c-4b59-a490-50611dacafb5")
  IsSpreadsheetPatternAvailable_Property_GUID* = DEFINE_GUID("6ff43732-e4b4-4555-97bc-ecdbbc4d1888")
  IsSpreadsheetItemPatternAvailable_Property_GUID* = DEFINE_GUID("9fe79b2a-2f94-43fd-996b-549e316f4acd")
  IsTransformPattern2Available_Property_GUID* = DEFINE_GUID("25980b4b-be04-4710-ab4a-fda31dbd2895")
  IsTextChildPatternAvailable_Property_GUID* = DEFINE_GUID("559e65df-30ff-43b5-b5ed-5b283b80c7e9")
  IsDragPatternAvailable_Property_GUID* = DEFINE_GUID("e997a7b7-1d39-4ca7-be0f-277fcf5605cc")
  IsDropTargetPatternAvailable_Property_GUID* = DEFINE_GUID("0686b62e-8e19-4aaf-873d-384f6d3b92be")
  IsPeripheral_Property_GUID* = DEFINE_GUID("da758276-7ed5-49d4-8e68-ecc9a2d300dd")
  PositionInSet_Property_GUID* = DEFINE_GUID("33d1dc54-641e-4d76-a6b1-13f341c1f896")
  SizeOfSet_Property_GUID* = DEFINE_GUID("1600d33c-3b9f-4369-9431-aa293f344cf1")
  Level_Property_GUID* = DEFINE_GUID("242ac529-cd36-400f-aad9-7876ef3af627")
  AnnotationTypes_Property_GUID* = DEFINE_GUID("64b71f76-53c4-4696-a219-20e940c9a176")
  AnnotationObjects_Property_GUID* = DEFINE_GUID("310910c8-7c6e-4f20-becd-4aaf6d191156")
  LandmarkType_Property_GUID* = DEFINE_GUID("454045f2-6f61-49f7-a4f8-b5f0cf82da1e")
  LocalizedLandmarkType_Property_GUID* = DEFINE_GUID("7ac81980-eafb-4fb2-bf91-f485bef5e8e1")
  FullDescription_Property_GUID* = DEFINE_GUID("0d4450ff-6aef-4f33-95dd-7befa72a4391")
  Value_Value_Property_GUID* = DEFINE_GUID("e95f5e64-269f-4a85-ba99-4092c3ea2986")
  Value_IsReadOnly_Property_GUID* = DEFINE_GUID("eb090f30-e24c-4799-a705-0d247bc037f8")
  RangeValue_Value_Property_GUID* = DEFINE_GUID("131f5d98-c50c-489d-abe5-ae220898c5f7")
  RangeValue_IsReadOnly_Property_GUID* = DEFINE_GUID("25fa1055-debf-4373-a79e-1f1a1908d3c4")
  RangeValue_Minimum_Property_GUID* = DEFINE_GUID("78cbd3b2-684d-4860-af93-d1f95cb022fd")
  RangeValue_Maximum_Property_GUID* = DEFINE_GUID("19319914-f979-4b35-a1a6-d37e05433473")
  RangeValue_LargeChange_Property_GUID* = DEFINE_GUID("a1f96325-3a3d-4b44-8e1f-4a46d9844019")
  RangeValue_SmallChange_Property_GUID* = DEFINE_GUID("81c2c457-3941-4107-9975-139760f7c072")
  Scroll_HorizontalScrollPercent_Property_GUID* = DEFINE_GUID("c7c13c0e-eb21-47ff-acc4-b5a3350f5191")
  Scroll_HorizontalViewSize_Property_GUID* = DEFINE_GUID("70c2e5d4-fcb0-4713-a9aa-af92ff79e4cd")
  Scroll_VerticalScrollPercent_Property_GUID* = DEFINE_GUID("6c8d7099-b2a8-4948-bff7-3cf9058bfefb")
  Scroll_VerticalViewSize_Property_GUID* = DEFINE_GUID("de6a2e22-d8c7-40c5-83ba-e5f681d53108")
  Scroll_HorizontallyScrollable_Property_GUID* = DEFINE_GUID("8b925147-28cd-49ae-bd63-f44118d2e719")
  Scroll_VerticallyScrollable_Property_GUID* = DEFINE_GUID("89164798-0068-4315-b89a-1e7cfbbc3dfc")
  Selection_Selection_Property_GUID* = DEFINE_GUID("aa6dc2a2-0e2b-4d38-96d5-34e470b81853")
  Selection_CanSelectMultiple_Property_GUID* = DEFINE_GUID("49d73da5-c883-4500-883d-8fcf8daf6cbe")
  Selection_IsSelectionRequired_Property_GUID* = DEFINE_GUID("b1ae4422-63fe-44e7-a5a5-a738c829b19a")
  Grid_RowCount_Property_GUID* = DEFINE_GUID("2a9505bf-c2eb-4fb6-b356-8245ae53703e")
  Grid_ColumnCount_Property_GUID* = DEFINE_GUID("fe96f375-44aa-4536-ac7a-2a75d71a3efc")
  GridItem_Row_Property_GUID* = DEFINE_GUID("6223972a-c945-4563-9329-fdc974af2553")
  GridItem_Column_Property_GUID* = DEFINE_GUID("c774c15c-62c0-4519-8bdc-47be573c8ad5")
  GridItem_RowSpan_Property_GUID* = DEFINE_GUID("4582291c-466b-4e93-8e83-3d1715ec0c5e")
  GridItem_ColumnSpan_Property_GUID* = DEFINE_GUID("583ea3f5-86d0-4b08-a6ec-2c5463ffc109")
  GridItem_Parent_Property_GUID* = DEFINE_GUID("9d912252-b97f-4ecc-8510-ea0e33427c72")
  Dock_DockPosition_Property_GUID* = DEFINE_GUID("6d67f02e-c0b0-4b10-b5b9-18d6ecf98760")
  ExpandCollapse_ExpandCollapseState_Property_GUID* = DEFINE_GUID("275a4c48-85a7-4f69-aba0-af157610002b")
  MultipleView_CurrentView_Property_GUID* = DEFINE_GUID("7a81a67a-b94f-4875-918b-65c8d2f998e5")
  MultipleView_SupportedViews_Property_GUID* = DEFINE_GUID("8d5db9fd-ce3c-4ae7-b788-400a3c645547")
  Window_CanMaximize_Property_GUID* = DEFINE_GUID("64fff53f-635d-41c1-950c-cb5adfbe28e3")
  Window_CanMinimize_Property_GUID* = DEFINE_GUID("b73b4625-5988-4b97-b4c2-a6fe6e78c8c6")
  Window_WindowVisualState_Property_GUID* = DEFINE_GUID("4ab7905f-e860-453e-a30a-f6431e5daad5")
  Window_WindowInteractionState_Property_GUID* = DEFINE_GUID("4fed26a4-0455-4fa2-b21c-c4da2db1ff9c")
  Window_IsModal_Property_GUID* = DEFINE_GUID("ff4e6892-37b9-4fca-8532-ffe674ecfeed")
  Window_IsTopmost_Property_GUID* = DEFINE_GUID("ef7d85d3-0937-4962-9241-b62345f24041")
  SelectionItem_IsSelected_Property_GUID* = DEFINE_GUID("f122835f-cd5f-43df-b79d-4b849e9e6020")
  SelectionItem_SelectionContainer_Property_GUID* = DEFINE_GUID("a4365b6e-9c1e-4b63-8b53-c2421dd1e8fb")
  Table_RowHeaders_Property_GUID* = DEFINE_GUID("d9e35b87-6eb8-4562-aac6-a8a9075236a8")
  Table_ColumnHeaders_Property_GUID* = DEFINE_GUID("aff1d72b-968d-42b1-b459-150b299da664")
  Table_RowOrColumnMajor_Property_GUID* = DEFINE_GUID("83be75c3-29fe-4a30-85e1-2a6277fd106e")
  TableItem_RowHeaderItems_Property_GUID* = DEFINE_GUID("b3f853a0-0574-4cd8-bcd7-ed5923572d97")
  TableItem_ColumnHeaderItems_Property_GUID* = DEFINE_GUID("967a56a3-74b6-431e-8de6-99c411031c58")
  Toggle_ToggleState_Property_GUID* = DEFINE_GUID("b23cdc52-22c2-4c6c-9ded-f5c422479ede")
  Transform_CanMove_Property_GUID* = DEFINE_GUID("1b75824d-208b-4fdf-bccd-f1f4e5741f4f")
  Transform_CanResize_Property_GUID* = DEFINE_GUID("bb98dca5-4c1a-41d4-a4f6-ebc128644180")
  Transform_CanRotate_Property_GUID* = DEFINE_GUID("10079b48-3849-476f-ac96-44a95c8440d9")
  LegacyIAccessible_ChildId_Property_GUID* = DEFINE_GUID("9a191b5d-9ef2-4787-a459-dcde885dd4e8")
  LegacyIAccessible_Name_Property_GUID* = DEFINE_GUID("caeb063d-40ae-4869-aa5a-1b8e5d666739")
  LegacyIAccessible_Value_Property_GUID* = DEFINE_GUID("b5c5b0b6-8217-4a77-97a5-190a85ed0156")
  LegacyIAccessible_Description_Property_GUID* = DEFINE_GUID("46448418-7d70-4ea9-9d27-b7e775cf2ad7")
  LegacyIAccessible_Role_Property_GUID* = DEFINE_GUID("6856e59f-cbaf-4e31-93e8-bcbf6f7e491c")
  LegacyIAccessible_State_Property_GUID* = DEFINE_GUID("df985854-2281-4340-ab9c-c60e2c5803f6")
  LegacyIAccessible_Help_Property_GUID* = DEFINE_GUID("94402352-161c-4b77-a98d-a872cc33947a")
  LegacyIAccessible_KeyboardShortcut_Property_GUID* = DEFINE_GUID("8f6909ac-00b8-4259-a41c-966266d43a8a")
  LegacyIAccessible_Selection_Property_GUID* = DEFINE_GUID("8aa8b1e0-0891-40cc-8b06-90d7d4166219")
  LegacyIAccessible_DefaultAction_Property_GUID* = DEFINE_GUID("3b331729-eaad-4502-b85f-92615622913c")
  Annotation_AnnotationTypeId_Property_GUID* = DEFINE_GUID("20ae484f-69ef-4c48-8f5b-c4938b206ac7")
  Annotation_AnnotationTypeName_Property_GUID* = DEFINE_GUID("9b818892-5ac9-4af9-aa96-f58a77b058e3")
  Annotation_Author_Property_GUID* = DEFINE_GUID("7a528462-9c5c-4a03-a974-8b307a9937f2")
  Annotation_DateTime_Property_GUID* = DEFINE_GUID("99b5ca5d-1acf-414b-a4d0-6b350b047578")
  Annotation_Target_Property_GUID* = DEFINE_GUID("b71b302d-2104-44ad-9c5c-092b4907d70f")
  Styles_StyleId_Property_GUID* = DEFINE_GUID("da82852f-3817-4233-82af-02279e72cc77")
  Styles_StyleName_Property_GUID* = DEFINE_GUID("1c12b035-05d1-4f55-9e8e-1489f3ff550d")
  Styles_FillColor_Property_GUID* = DEFINE_GUID("63eff97a-a1c5-4b1d-84eb-b765f2edd632")
  Styles_FillPatternStyle_Property_GUID* = DEFINE_GUID("81cf651f-482b-4451-a30a-e1545e554fb8")
  Styles_Shape_Property_GUID* = DEFINE_GUID("c71a23f8-778c-400d-8458-3b543e526984")
  Styles_FillPatternColor_Property_GUID* = DEFINE_GUID("939a59fe-8fbd-4e75-a271-ac4595195163")
  Styles_ExtendedProperties_Property_GUID* = DEFINE_GUID("f451cda0-ba0a-4681-b0b0-0dbdb53e58f3")
  SpreadsheetItem_Formula_Property_GUID* = DEFINE_GUID("e602e47d-1b47-4bea-87cf-3b0b0b5c15b6")
  SpreadsheetItem_AnnotationObjects_Property_GUID* = DEFINE_GUID("a3194c38-c9bc-4604-9396-ae3f9f457f7b")
  SpreadsheetItem_AnnotationTypes_Property_GUID* = DEFINE_GUID("c70c51d0-d602-4b45-afbc-b4712b96d72b")
  Transform2_CanZoom_Property_GUID* = DEFINE_GUID("f357e890-a756-4359-9ca6-86702bf8f381")
  LiveSetting_Property_GUID* = DEFINE_GUID("c12bcd8e-2a8e-4950-8ae7-3625111d58eb")
  Drag_IsGrabbed_Property_GUID* = DEFINE_GUID("45f206f3-75cc-4cca-a9b9-fcdfb982d8a2")
  Drag_GrabbedItems_Property_GUID* = DEFINE_GUID("77c1562c-7b86-4b21-9ed7-3cefda6f4c43")
  Drag_DropEffect_Property_GUID* = DEFINE_GUID("646f2779-48d3-4b23-8902-4bf100005df3")
  Drag_DropEffects_Property_GUID* = DEFINE_GUID("f5d61156-7ce6-49be-a836-9269dcec920f")
  DropTarget_DropTargetEffect_Property_GUID* = DEFINE_GUID("8bb75975-a0ca-4981-b818-87fc66e9509d")
  DropTarget_DropTargetEffects_Property_GUID* = DEFINE_GUID("bc1dd4ed-cb89-45f1-a592-e03b08ae790f")
  Transform2_ZoomLevel_Property_GUID* = DEFINE_GUID("eee29f1a-f4a2-4b5b-ac65-95cf93283387")
  Transform2_ZoomMinimum_Property_GUID* = DEFINE_GUID("742ccc16-4ad1-4e07-96fe-b122c6e6b22b")
  Transform2_ZoomMaximum_Property_GUID* = DEFINE_GUID("42ab6b77-ceb0-4eca-b82a-6cfa5fa1fc08")
  FlowsFrom_Property_GUID* = DEFINE_GUID("05c6844f-19de-48f8-95fa-880d5b0fd615")
  FillColor_Property_GUID* = DEFINE_GUID("6e0ec4d0-e2a8-4a56-9de7-953389933b39")
  OutlineColor_Property_GUID* = DEFINE_GUID("c395d6c0-4b55-4762-a073-fd303a634f52")
  FillType_Property_GUID* = DEFINE_GUID("c6fc74e4-8cb9-429c-a9e1-9bc4ac372b62")
  VisualEffects_Property_GUID* = DEFINE_GUID("e61a8565-aad9-46d7-9e70-4e8a8420d420")
  OutlineThickness_Property_GUID* = DEFINE_GUID("13e67cc7-dac2-4888-bdd3-375c62fa9618")
  CenterPoint_Property_GUID* = DEFINE_GUID("0cb00c08-540c-4edb-9445-26359ea69785")
  Rotation_Property_GUID* = DEFINE_GUID("767cdc7d-aec0-4110-ad32-30edd403492e")
  Size_Property_GUID* = DEFINE_GUID("2b5f761d-f885-4404-973f-9b1d98e36d8f")
  ToolTipOpened_Event_GUID* = DEFINE_GUID("3f4b97ff-2edc-451d-bca4-95a3188d5b03")
  ToolTipClosed_Event_GUID* = DEFINE_GUID("276d71ef-24a9-49b6-8e97-da98b401bbcd")
  StructureChanged_Event_GUID* = DEFINE_GUID("59977961-3edd-4b11-b13b-676b2a2a6ca9")
  MenuOpened_Event_GUID* = DEFINE_GUID("ebe2e945-66ca-4ed1-9ff8-2ad7df0a1b08")
  AutomationPropertyChanged_Event_GUID* = DEFINE_GUID("2527fba1-8d7a-4630-a4cc-e66315942f52")
  AutomationFocusChanged_Event_GUID* = DEFINE_GUID("b68a1f17-f60d-41a7-a3cc-b05292155fe0")
  ActiveTextPositionChanged_Event_GUID* = DEFINE_GUID("a5c09e9c-c77d-4f25-b491-e5bb7017cbd4")
  AsyncContentLoaded_Event_GUID* = DEFINE_GUID("5fdee11c-d2fa-4fb9-904e-5cbee894d5ef")
  MenuClosed_Event_GUID* = DEFINE_GUID("3cf1266e-1582-4041-acd7-88a35a965297")
  LayoutInvalidated_Event_GUID* = DEFINE_GUID("ed7d6544-a6bd-4595-9bae-3d28946cc715")
  Invoke_Invoked_Event_GUID* = DEFINE_GUID("dfd699f0-c915-49dd-b422-dde785c3d24b")
  SelectionItem_ElementAddedToSelectionEvent_Event_GUID* = DEFINE_GUID("3c822dd1-c407-4dba-91dd-79d4aed0aec6")
  SelectionItem_ElementRemovedFromSelectionEvent_Event_GUID* = DEFINE_GUID("097fa8a9-7079-41af-8b9c-0934d8305e5c")
  SelectionItem_ElementSelectedEvent_Event_GUID* = DEFINE_GUID("b9c7dbfb-4ebe-4532-aaf4-008cf647233c")
  Selection_InvalidatedEvent_Event_GUID* = DEFINE_GUID("cac14904-16b4-4b53-8e47-4cb1df267bb7")
  Text_TextSelectionChangedEvent_Event_GUID* = DEFINE_GUID("918edaa1-71b3-49ae-9741-79beb8d358f3")
  Text_TextChangedEvent_Event_GUID* = DEFINE_GUID("4a342082-f483-48c4-ac11-a84b435e2a84")
  Window_WindowOpened_Event_GUID* = DEFINE_GUID("d3e81d06-de45-4f2f-9633-de9e02fb65af")
  Window_WindowClosed_Event_GUID* = DEFINE_GUID("edf141f8-fa67-4e22-bbf7-944e05735ee2")
  MenuModeStart_Event_GUID* = DEFINE_GUID("18d7c631-166a-4ac9-ae3b-ef4b5420e681")
  MenuModeEnd_Event_GUID* = DEFINE_GUID("9ecd4c9f-80dd-47b8-8267-5aec06bb2cff")
  InputReachedTarget_Event_GUID* = DEFINE_GUID("93ed549a-0549-40f0-bedb-28e44f7de2a3")
  InputReachedOtherElement_Event_GUID* = DEFINE_GUID("ed201d8a-4e6c-415e-a874-2460c9b66ba8")
  InputDiscarded_Event_GUID* = DEFINE_GUID("7f36c367-7b18-417c-97e3-9d58ddc944ab")
  SystemAlert_Event_GUID* = DEFINE_GUID("d271545d-7a3a-47a7-8474-81d29a2451c9")
  LiveRegionChanged_Event_GUID* = DEFINE_GUID("102d5e90-e6a9-41b6-b1c5-a9b1929d9510")
  HostedFragmentRootsInvalidated_Event_GUID* = DEFINE_GUID("e6bdb03e-0921-4ec5-8dcf-eae877b0426b")
  Drag_DragStart_Event_GUID* = DEFINE_GUID("883a480b-3aa9-429d-95e4-d9c8d011f0dd")
  Drag_DragCancel_Event_GUID* = DEFINE_GUID("c3ede6fa-3451-4e0f-9e71-df9c280a4657")
  Drag_DragComplete_Event_GUID* = DEFINE_GUID("38e96188-ef1f-463e-91ca-3a7792c29caf")
  DropTarget_DragEnter_Event_GUID* = DEFINE_GUID("aad9319b-032c-4a88-961d-1cf579581e34")
  DropTarget_DragLeave_Event_GUID* = DEFINE_GUID("0f82eb15-24a2-4988-9217-de162aee272b")
  DropTarget_Dropped_Event_GUID* = DEFINE_GUID("622cead8-1edb-4a3d-abbc-be2211ff68b5")
  Invoke_Pattern_GUID* = DEFINE_GUID("d976c2fc-66ea-4a6e-b28f-c24c7546ad37")
  Selection_Pattern_GUID* = DEFINE_GUID("66e3b7e8-d821-4d25-8761-435d2c8b253f")
  Value_Pattern_GUID* = DEFINE_GUID("17faad9e-c877-475b-b933-77332779b637")
  RangeValue_Pattern_GUID* = DEFINE_GUID("18b00d87-b1c9-476a-bfbd-5f0bdb926f63")
  Scroll_Pattern_GUID* = DEFINE_GUID("895fa4b4-759d-4c50-8e15-03460672003c")
  ExpandCollapse_Pattern_GUID* = DEFINE_GUID("ae05efa2-f9d1-428a-834c-53a5c52f9b8b")
  Grid_Pattern_GUID* = DEFINE_GUID("260a2ccb-93a8-4e44-a4c1-3df397f2b02b")
  GridItem_Pattern_GUID* = DEFINE_GUID("f2d5c877-a462-4957-a2a5-2c96b303bc63")
  MultipleView_Pattern_GUID* = DEFINE_GUID("547a6ae4-113f-47c4-850f-db4dfa466b1d")
  Window_Pattern_GUID* = DEFINE_GUID("27901735-c760-4994-ad11-5919e606b110")
  SelectionItem_Pattern_GUID* = DEFINE_GUID("9bc64eeb-87c7-4b28-94bb-4d9fa437b6ef")
  Dock_Pattern_GUID* = DEFINE_GUID("9cbaa846-83c8-428d-827f-7e6063fe0620")
  Table_Pattern_GUID* = DEFINE_GUID("c415218e-a028-461e-aa92-8f925cf79351")
  TableItem_Pattern_GUID* = DEFINE_GUID("df1343bd-1888-4a29-a50c-b92e6de37f6f")
  Text_Pattern_GUID* = DEFINE_GUID("8615f05d-7de5-44fd-a679-2ca4b46033a8")
  Toggle_Pattern_GUID* = DEFINE_GUID("0b419760-e2f4-43ff-8c5f-9457c82b56e9")
  Transform_Pattern_GUID* = DEFINE_GUID("24b46fdb-587e-49f1-9c4a-d8e98b664b7b")
  ScrollItem_Pattern_GUID* = DEFINE_GUID("4591d005-a803-4d5c-b4d5-8d2800f906a7")
  LegacyIAccessible_Pattern_GUID* = DEFINE_GUID("54cc0a9f-3395-48af-ba8d-73f85690f3e0")
  ItemContainer_Pattern_GUID* = DEFINE_GUID("3d13da0f-8b9a-4a99-85fa-c5c9a69f1ed4")
  VirtualizedItem_Pattern_GUID* = DEFINE_GUID("f510173e-2e71-45e9-a6e5-62f6ed8289d5")
  SynchronizedInput_Pattern_GUID* = DEFINE_GUID("05c288a6-c47b-488b-b653-33977a551b8b")
  ObjectModel_Pattern_GUID* = DEFINE_GUID("3e04acfe-08fc-47ec-96bc-353fa3b34aa7")
  Annotation_Pattern_GUID* = DEFINE_GUID("f6c72ad7-356c-4850-9291-316f608a8c84")
  Text_Pattern2_GUID* = DEFINE_GUID("498479a2-5b22-448d-b6e4-647490860698")
  TextEdit_Pattern_GUID* = DEFINE_GUID("69f3ff89-5af9-4c75-9340-f2de292e4591")
  CustomNavigation_Pattern_GUID* = DEFINE_GUID("afea938a-621e-4054-bb2c-2f46114dac3f")
  Styles_Pattern_GUID* = DEFINE_GUID("1ae62655-da72-4d60-a153-e5aa6988e3bf")
  Spreadsheet_Pattern_GUID* = DEFINE_GUID("6a5b24c9-9d1e-4b85-9e44-c02e3169b10b")
  SpreadsheetItem_Pattern_GUID* = DEFINE_GUID("32cf83ff-f1a8-4a8c-8658-d47ba74e20ba")
  Tranform_Pattern2_GUID* = DEFINE_GUID("8afcfd07-a369-44de-988b-2f7ff49fb8a8")
  TextChild_Pattern_GUID* = DEFINE_GUID("7533cab7-3bfe-41ef-9e85-e2638cbe169e")
  Drag_Pattern_GUID* = DEFINE_GUID("c0bee21f-ccb3-4fed-995b-114f6e3d2728")
  DropTarget_Pattern_GUID* = DEFINE_GUID("0bcbec56-bd34-4b7b-9fd5-2659905ea3dc")
  Button_Control_GUID* = DEFINE_GUID("5a78e369-c6a1-4f33-a9d7-79f20d0c788e")
  Calendar_Control_GUID* = DEFINE_GUID("8913eb88-00e5-46bc-8e4e-14a786e165a1")
  CheckBox_Control_GUID* = DEFINE_GUID("fb50f922-a3db-49c0-8bc3-06dad55778e2")
  ComboBox_Control_GUID* = DEFINE_GUID("54cb426c-2f33-4fff-aaa1-aef60dac5deb")
  Edit_Control_GUID* = DEFINE_GUID("6504a5c8-2c86-4f87-ae7b-1abddc810cf9")
  Hyperlink_Control_GUID* = DEFINE_GUID("8a56022c-b00d-4d15-8ff0-5b6b266e5e02")
  Image_Control_GUID* = DEFINE_GUID("2d3736e4-6b16-4c57-a962-f93260a75243")
  ListItem_Control_GUID* = DEFINE_GUID("7b3717f2-44d1-4a58-98a8-f12a9b8f78e2")
  List_Control_GUID* = DEFINE_GUID("9b149ee1-7cca-4cfc-9af1-cac7bddd3031")
  Menu_Control_GUID* = DEFINE_GUID("2e9b1440-0ea8-41fd-b374-c1ea6f503cd1")
  MenuBar_Control_GUID* = DEFINE_GUID("cc384250-0e7b-4ae8-95ae-a08f261b52ee")
  MenuItem_Control_GUID* = DEFINE_GUID("f45225d3-d0a0-49d8-9834-9a000d2aeddc")
  ProgressBar_Control_GUID* = DEFINE_GUID("228c9f86-c36c-47bb-9fb6-a5834bfc53a4")
  RadioButton_Control_GUID* = DEFINE_GUID("3bdb49db-fe2c-4483-b3e1-e57f219440c6")
  ScrollBar_Control_GUID* = DEFINE_GUID("daf34b36-5065-4946-b22f-92595fc0751a")
  Slider_Control_GUID* = DEFINE_GUID("b033c24b-3b35-4cea-b609-763682fa660b")
  Spinner_Control_GUID* = DEFINE_GUID("60cc4b38-3cb1-4161-b442-c6b726c17825")
  StatusBar_Control_GUID* = DEFINE_GUID("d45e7d1b-5873-475f-95a4-0433e1f1b00a")
  Tab_Control_GUID* = DEFINE_GUID("38cd1f2d-337a-4bd2-a5e3-adb469e30bd3")
  TabItem_Control_GUID* = DEFINE_GUID("2c6a634f-921b-4e6e-b26e-08fcb0798f4c")
  Text_Control_GUID* = DEFINE_GUID("ae9772dc-d331-4f09-be20-7e6dfaf07b0a")
  ToolBar_Control_GUID* = DEFINE_GUID("8f06b751-e182-4e98-8893-2284543a7dce")
  ToolTip_Control_GUID* = DEFINE_GUID("05ddc6d1-2137-4768-98ea-73f52f7134f3")
  Tree_Control_GUID* = DEFINE_GUID("7561349c-d241-43f4-9908-b5f091bee611")
  TreeItem_Control_GUID* = DEFINE_GUID("62c9feb9-8ffc-4878-a3a4-96b030315c18")
  Custom_Control_GUID* = DEFINE_GUID("f29ea0c3-adb7-430a-ba90-e52c7313e6ed")
  Group_Control_GUID* = DEFINE_GUID("ad50aa1c-e8c8-4774-ae1b-dd86df0b3bdc")
  Thumb_Control_GUID* = DEFINE_GUID("701ca877-e310-4dd6-b644-797e4faea213")
  DataGrid_Control_GUID* = DEFINE_GUID("84b783af-d103-4b0a-8415-e73942410f4b")
  DataItem_Control_GUID* = DEFINE_GUID("a0177842-d94f-42a5-814b-6068addc8da5")
  Document_Control_GUID* = DEFINE_GUID("3cd6bb6f-6f08-4562-b229-e4e2fc7a9eb4")
  SplitButton_Control_GUID* = DEFINE_GUID("7011f01f-4ace-4901-b461-920a6f1ca650")
  Window_Control_GUID* = DEFINE_GUID("e13a7242-f462-4f4d-aec1-53b28d6c3290")
  Pane_Control_GUID* = DEFINE_GUID("5c2b3f5b-9182-42a3-8dec-8c04c1ee634d")
  Header_Control_GUID* = DEFINE_GUID("5b90cbce-78fb-4614-82b6-554d74718e67")
  HeaderItem_Control_GUID* = DEFINE_GUID("e6bc12cb-7c8e-49cf-b168-4a93a32bebb0")
  Table_Control_GUID* = DEFINE_GUID("773bfa0e-5bc4-4deb-921b-de7b3206229e")
  TitleBar_Control_GUID* = DEFINE_GUID("98aa55bf-3bb0-4b65-836e-2ea30dbc171f")
  Separator_Control_GUID* = DEFINE_GUID("8767eba3-2a63-4ab0-ac8d-aa50e23de978")
  SemanticZoom_Control_GUID* = DEFINE_GUID("5fd34a43-061e-42c8-b589-9dccf74bc43a")
  AppBar_Control_GUID* = DEFINE_GUID("6114908d-cc02-4d37-875b-b530c7139554")
  Text_AnimationStyle_Attribute_GUID* = DEFINE_GUID("628209f0-7c9a-4d57-be64-1f1836571ff5")
  Text_BackgroundColor_Attribute_GUID* = DEFINE_GUID("fdc49a07-583d-4f17-ad27-77fc832a3c0b")
  Text_BulletStyle_Attribute_GUID* = DEFINE_GUID("c1097c90-d5c4-4237-9781-3bec8ba54e48")
  Text_CapStyle_Attribute_GUID* = DEFINE_GUID("fb059c50-92cc-49a5-ba8f-0aa872bba2f3")
  Text_Culture_Attribute_GUID* = DEFINE_GUID("c2025af9-a42d-4ced-a1fb-c6746315222e")
  Text_FontName_Attribute_GUID* = DEFINE_GUID("64e63ba8-f2e5-476e-a477-1734feaaf726")
  Text_FontSize_Attribute_GUID* = DEFINE_GUID("dc5eeeff-0506-4673-93f2-377e4a8e01f1")
  Text_FontWeight_Attribute_GUID* = DEFINE_GUID("6fc02359-b316-4f5f-b401-f1ce55741853")
  Text_ForegroundColor_Attribute_GUID* = DEFINE_GUID("72d1c95d-5e60-471a-96b1-6c1b3b77a436")
  Text_HorizontalTextAlignment_Attribute_GUID* = DEFINE_GUID("04ea6161-fba3-477a-952a-bb326d026a5b")
  Text_IndentationFirstLine_Attribute_GUID* = DEFINE_GUID("206f9ad5-c1d3-424a-8182-6da9a7f3d632")
  Text_IndentationLeading_Attribute_GUID* = DEFINE_GUID("5cf66bac-2d45-4a4b-b6c9-f7221d2815b0")
  Text_IndentationTrailing_Attribute_GUID* = DEFINE_GUID("97ff6c0f-1ce4-408a-b67b-94d83eb69bf2")
  Text_IsHidden_Attribute_GUID* = DEFINE_GUID("360182fb-bdd7-47f6-ab69-19e33f8a3344")
  Text_IsItalic_Attribute_GUID* = DEFINE_GUID("fce12a56-1336-4a34-9663-1bab47239320")
  Text_IsReadOnly_Attribute_GUID* = DEFINE_GUID("a738156b-ca3e-495e-9514-833c440feb11")
  Text_IsSubscript_Attribute_GUID* = DEFINE_GUID("f0ead858-8f53-413c-873f-1a7d7f5e0de4")
  Text_IsSuperscript_Attribute_GUID* = DEFINE_GUID("da706ee4-b3aa-4645-a41f-cd25157dea76")
  Text_MarginBottom_Attribute_GUID* = DEFINE_GUID("7ee593c4-72b4-4cac-9271-3ed24b0e4d42")
  Text_MarginLeading_Attribute_GUID* = DEFINE_GUID("9e9242d0-5ed0-4900-8e8a-eecc03835afc")
  Text_MarginTop_Attribute_GUID* = DEFINE_GUID("683d936f-c9b9-4a9a-b3d9-d20d33311e2a")
  Text_MarginTrailing_Attribute_GUID* = DEFINE_GUID("af522f98-999d-40af-a5b2-0169d0342002")
  Text_OutlineStyles_Attribute_GUID* = DEFINE_GUID("5b675b27-db89-46fe-970c-614d523bb97d")
  Text_OverlineColor_Attribute_GUID* = DEFINE_GUID("83ab383a-fd43-40da-ab3e-ecf8165cbb6d")
  Text_OverlineStyle_Attribute_GUID* = DEFINE_GUID("0a234d66-617e-427f-871d-e1ff1e0c213f")
  Text_StrikethroughColor_Attribute_GUID* = DEFINE_GUID("bfe15a18-8c41-4c5a-9a0b-04af0e07f487")
  Text_StrikethroughStyle_Attribute_GUID* = DEFINE_GUID("72913ef1-da00-4f01-899c-ac5a8577a307")
  Text_Tabs_Attribute_GUID* = DEFINE_GUID("2e68d00b-92fe-42d8-899a-a784aa4454a1")
  Text_TextFlowDirections_Attribute_GUID* = DEFINE_GUID("8bdf8739-f420-423e-af77-20a5d973a907")
  Text_UnderlineColor_Attribute_GUID* = DEFINE_GUID("bfa12c73-fde2-4473-bf64-1036d6aa0f45")
  Text_UnderlineStyle_Attribute_GUID* = DEFINE_GUID("5f3b21c0-ede4-44bd-9c36-3853038cbfeb")
  Text_AnnotationTypes_Attribute_GUID* = DEFINE_GUID("ad2eb431-ee4e-4be1-a7ba-5559155a73ef")
  Text_AnnotationObjects_Attribute_GUID* = DEFINE_GUID("ff41cf68-e7ab-40b9-8c72-72a8ed94017d")
  Text_StyleName_Attribute_GUID* = DEFINE_GUID("22c9e091-4d66-45d8-a828-737bab4c98a7")
  Text_StyleId_Attribute_GUID* = DEFINE_GUID("14c300de-c32b-449b-ab7c-b0e0789aea5d")
  Text_Link_Attribute_GUID* = DEFINE_GUID("b38ef51d-9e8d-4e46-9144-56ebe177329b")
  Text_IsActive_Attribute_GUID* = DEFINE_GUID("f5a4e533-e1b8-436b-935d-b57aa3f558c4")
  Text_SelectionActiveEnd_Attribute_GUID* = DEFINE_GUID("1f668cc3-9bbf-416b-b0a2-f89f86f6612c")
  Text_CaretPosition_Attribute_GUID* = DEFINE_GUID("b227b131-9889-4752-a91b-733efdc5c5a0")
  Text_CaretBidiMode_Attribute_GUID* = DEFINE_GUID("929ee7a6-51d3-4715-96dc-b694fa24a168")
  Text_BeforeParagraphSpacing_Attribute_GUID* = DEFINE_GUID("be7b0ab1-c822-4a24-85e9-c8f2650fc79c")
  Text_AfterParagraphSpacing_Attribute_GUID* = DEFINE_GUID("588cbb38-e62f-497c-b5d1-ccdf0ee823d8")
  Text_LineSpacing_Attribute_GUID* = DEFINE_GUID("63ff70ae-d943-4b47-8ab7-a7a033d3214b")
  Text_BeforeSpacing_Attribute_GUID* = DEFINE_GUID("be7b0ab1-c822-4a24-85e9-c8f2650fc79c")
  Text_AfterSpacing_Attribute_GUID* = DEFINE_GUID("588cbb38-e62f-497c-b5d1-ccdf0ee823d8")
  Text_SayAsInterpretAs_Attribute_GUID* = DEFINE_GUID("b38ad6ac-eee1-4b6e-88cc-014cefa93fcb")
  TextEdit_TextChanged_Event_GUID* = DEFINE_GUID("120b0308-ec22-4eb8-9c98-9867cda1b165")
  TextEdit_ConversionTargetChanged_Event_GUID* = DEFINE_GUID("3388c183-ed4f-4c8b-9baa-364d51d8847f")
  Changes_Event_GUID* = DEFINE_GUID("7df26714-614f-4e05-9488-716c5ba19436")
  Annotation_Custom_GUID* = DEFINE_GUID("9ec82750-3931-4952-85bc-1dbff78a43e3")
  Annotation_SpellingError_GUID* = DEFINE_GUID("ae85567e-9ece-423f-81b7-96c43d53e50e")
  Annotation_GrammarError_GUID* = DEFINE_GUID("757a048d-4518-41c6-854c-dc009b7cfb53")
  Annotation_Comment_GUID* = DEFINE_GUID("fd2fda30-26b3-4c06-8bc7-98f1532e46fd")
  Annotation_FormulaError_GUID* = DEFINE_GUID("95611982-0cab-46d5-a2f0-e30d1905f8bf")
  Annotation_TrackChanges_GUID* = DEFINE_GUID("21e6e888-dc14-4016-ac27-190553c8c470")
  Annotation_Header_GUID* = DEFINE_GUID("867b409b-b216-4472-a219-525e310681f8")
  Annotation_Footer_GUID* = DEFINE_GUID("cceab046-1833-47aa-8080-701ed0b0c832")
  Annotation_Highlighted_GUID* = DEFINE_GUID("757c884e-8083-4081-8b9c-e87f5072f0e4")
  Annotation_Endnote_GUID* = DEFINE_GUID("7565725c-2d99-4839-960d-33d3b866aba5")
  Annotation_Footnote_GUID* = DEFINE_GUID("3de10e21-4125-42db-8620-be8083080624")
  Annotation_InsertionChange_GUID* = DEFINE_GUID("0dbeb3a6-df15-4164-a3c0-e21a8ce931c4")
  Annotation_DeletionChange_GUID* = DEFINE_GUID("be3d5b05-951d-42e7-901d-adc8c2cf34d0")
  Annotation_MoveChange_GUID* = DEFINE_GUID("9da587eb-23e5-4490-b385-1a22ddc8b187")
  Annotation_FormatChange_GUID* = DEFINE_GUID("eb247345-d4f1-41ce-8e52-f79b69635e48")
  Annotation_UnsyncedChange_GUID* = DEFINE_GUID("1851116a-0e47-4b30-8cb5-d7dae4fbcd1b")
  Annotation_EditingLockedChange_GUID* = DEFINE_GUID("c31f3e1c-7423-4dac-8348-41f099ff6f64")
  Annotation_ExternalChange_GUID* = DEFINE_GUID("75a05b31-5f11-42fd-887d-dfa010db2392")
  Annotation_ConflictingChange_GUID* = DEFINE_GUID("98af8802-517c-459f-af13-016d3fab877e")
  Annotation_Author_GUID* = DEFINE_GUID("f161d3a7-f81b-4128-b17f-71f690914520")
  Annotation_AdvancedProofingIssue_GUID* = DEFINE_GUID("dac7b72c-c0f2-4b84-b90d-5fafc0f0ef1c")
  Annotation_DataValidationError_GUID* = DEFINE_GUID("c8649fa8-9775-437e-ad46-e709d93c2343")
  Annotation_CircularReferenceError_GUID* = DEFINE_GUID("25bd9cf4-1745-4659-ba67-727f0318c616")
  Annotation_Mathematics_GUID* = DEFINE_GUID("eaab634b-26d0-40c1-8073-57ca1c633c9b")
  Changes_Summary_GUID* = DEFINE_GUID("313d65a6-e60f-4d62-9861-55afd728d207")
  StyleId_Custom_GUID* = DEFINE_GUID("ef2edd3e-a999-4b7c-a378-09bbd52a3516")
  StyleId_Heading1_GUID* = DEFINE_GUID("7f7e8f69-6866-4621-930c-9a5d0ca5961c")
  StyleId_Heading2_GUID* = DEFINE_GUID("baa9b241-5c69-469d-85ad-474737b52b14")
  StyleId_Heading3_GUID* = DEFINE_GUID("bf8be9d2-d8b8-4ec5-8c52-9cfb0d035970")
  StyleId_Heading4_GUID* = DEFINE_GUID("8436ffc0-9578-45fc-83a4-ff40053315dd")
  StyleId_Heading5_GUID* = DEFINE_GUID("909f424d-0dbf-406e-97bb-4e773d9798f7")
  StyleId_Heading6_GUID* = DEFINE_GUID("89d23459-5d5b-4824-a420-11d3ed82e40f")
  StyleId_Heading7_GUID* = DEFINE_GUID("a3790473-e9ae-422d-b8e3-3b675c6181a4")
  StyleId_Heading8_GUID* = DEFINE_GUID("2bc14145-a40c-4881-84ae-f2235685380c")
  StyleId_Heading9_GUID* = DEFINE_GUID("c70d9133-bb2a-43d3-8ac6-33657884b0f0")
  StyleId_Title_GUID* = DEFINE_GUID("15d8201a-ffcf-481f-b0a1-30b63be98f07")
  StyleId_Subtitle_GUID* = DEFINE_GUID("b5d9fc17-5d6f-4420-b439-7cb19ad434e2")
  StyleId_Normal_GUID* = DEFINE_GUID("cd14d429-e45e-4475-a1c5-7f9e6be96eba")
  StyleId_Emphasis_GUID* = DEFINE_GUID("ca6e7dbe-355e-4820-95a0-925f041d3470")
  StyleId_Quote_GUID* = DEFINE_GUID("5d1c21ea-8195-4f6c-87ea-5dabece64c1d")
  StyleId_BulletedList_GUID* = DEFINE_GUID("5963ed64-6426-4632-8caf-a32ad402d91a")
  StyleId_NumberedList_GUID* = DEFINE_GUID("1e96dbd5-64c3-43d0-b1ee-b53b06e3eddf")
  Notification_Event_GUID* = DEFINE_GUID("72c5a2f7-9788-480f-b8eb-4dee00f6186f")
  SID_IsUIAutomationObject* = DEFINE_GUID("b96fdb85-7204-4724-842b-c7059dedb9d0")
  SID_ControlElementProvider* = DEFINE_GUID("f4791d68-e254-4ba3-9a53-26a5c5497946")
  IsSelectionPattern2Available_Property_GUID* = DEFINE_GUID("490806fb-6e89-4a47-8319-d266e511f021")
  Selection2_FirstSelectedItem_Property_GUID* = DEFINE_GUID("cc24ea67-369c-4e55-9ff7-38da69540c29")
  Selection2_LastSelectedItem_Property_GUID* = DEFINE_GUID("cf7bda90-2d83-49f8-860c-9ce394cf89b4")
  Selection2_CurrentSelectedItem_Property_GUID* = DEFINE_GUID("34257c26-83b5-41a6-939c-ae841c136236")
  Selection2_ItemCount_Property_GUID* = DEFINE_GUID("bb49eb9f-456d-4048-b591-9c2026b84636")
  Selection_Pattern2_GUID* = DEFINE_GUID("fba25cab-ab98-49f7-a7dc-fe539dc15be7")
  HeadingLevel_Property_GUID* = DEFINE_GUID("29084272-aaaf-4a30-8796-3c12f62b6bbb")
  IsDialog_Property_GUID* = DEFINE_GUID("9d0dfb9b-8436-4501-bbbb-e534a4fb3b3f")
  ConditionType_True* = 0
  ConditionType_False* = 1
  ConditionType_Property* = 2
  ConditionType_And* = 3
  ConditionType_Or* = 4
  ConditionType_Not* = 5
  NormalizeState_None* = 0
  NormalizeState_View* = 1
  NormalizeState_Custom* = 2
  ProviderType_BaseHwnd* = 0
  ProviderType_Proxy* = 1
  ProviderType_NonClientArea* = 2
  AutomationIdentifierType_Property* = 0
  AutomationIdentifierType_Pattern* = 1
  AutomationIdentifierType_Event* = 2
  AutomationIdentifierType_ControlType* = 3
  AutomationIdentifierType_TextAttribute* = 4
  AutomationIdentifierType_LandmarkType* = 5
  AutomationIdentifierType_Annotation* = 6
  AutomationIdentifierType_Changes* = 7
  AutomationIdentifierType_Style* = 8
  EventArgsType_Simple* = 0
  EventArgsType_PropertyChanged* = 1
  EventArgsType_StructureChanged* = 2
  EventArgsType_AsyncContentLoaded* = 3
  EventArgsType_WindowClosed* = 4
  EventArgsType_TextEditTextChanged* = 5
  EventArgsType_Changes* = 6
  EventArgsType_Notification* = 7
  EventArgsType_ActiveTextPositionChanged* = 8
  AsyncContentLoadedState_Beginning* = 0
  AsyncContentLoadedState_Progress* = 1
  AsyncContentLoadedState_Completed* = 2
  UIA_IAFP_DEFAULT* = 0x0000
  UIA_IAFP_UNWRAP_BRIDGE* = 0x0001
  UIA_PFIA_DEFAULT* = 0x0000
  UIA_PFIA_UNWRAP_BRIDGE* = 0x0001
type
  UiaProviderCallback* = proc (hwnd: HWND, providerType: ProviderType): ptr SAFEARRAY {.stdcall.}
  UiaEventArgs* {.pure.} = object
    Type*: EventArgsType
    EventId*: int32
  UiaEventCallback* = proc (pArgs: ptr UiaEventArgs, pRequestedData: ptr SAFEARRAY, pTreeStructure: BSTR): void {.stdcall.}
  UiaRect* {.pure.} = object
    left*: float64
    top*: float64
    width*: float64
    height*: float64
  UiaPoint* {.pure.} = object
    x*: float64
    y*: float64
  UiaChangeInfo* {.pure.} = object
    uiaId*: int32
    payload*: VARIANT
    extraInfo*: VARIANT
  UIAutomationParameter* {.pure.} = object
    `type`*: UIAutomationType
    pData*: pointer
  UIAutomationPropertyInfo* {.pure.} = object
    guid*: GUID
    pProgrammaticName*: LPCWSTR
    `type`*: UIAutomationType
  UIAutomationEventInfo* {.pure.} = object
    guid*: GUID
    pProgrammaticName*: LPCWSTR
  UIAutomationMethodInfo* {.pure.} = object
    pProgrammaticName*: LPCWSTR
    doSetFocus*: BOOL
    cInParameters*: UINT
    cOutParameters*: UINT
    pParameterTypes*: ptr UIAutomationType
    pParameterNames*: ptr LPCWSTR
  IUIAutomationPatternInstance* {.pure.} = object
    lpVtbl*: ptr IUIAutomationPatternInstanceVtbl
  IUIAutomationPatternInstanceVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetProperty*: proc(self: ptr IUIAutomationPatternInstance, index: UINT, cached: BOOL, `type`: UIAutomationType, pPtr: pointer): HRESULT {.stdcall.}
    CallMethod*: proc(self: ptr IUIAutomationPatternInstance, index: UINT, pParams: ptr UIAutomationParameter, cParams: UINT): HRESULT {.stdcall.}
  IUIAutomationPatternHandler* {.pure.} = object
    lpVtbl*: ptr IUIAutomationPatternHandlerVtbl
  IUIAutomationPatternHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateClientWrapper*: proc(self: ptr IUIAutomationPatternHandler, pPatternInstance: ptr IUIAutomationPatternInstance, pClientWrapper: ptr ptr IUnknown): HRESULT {.stdcall.}
    Dispatch*: proc(self: ptr IUIAutomationPatternHandler, pTarget: ptr IUnknown, index: UINT, pParams: ptr UIAutomationParameter, cParams: UINT): HRESULT {.stdcall.}
  UIAutomationPatternInfo* {.pure.} = object
    guid*: GUID
    pProgrammaticName*: LPCWSTR
    providerInterfaceId*: GUID
    clientInterfaceId*: GUID
    cProperties*: UINT
    pProperties*: ptr UIAutomationPropertyInfo
    cMethods*: UINT
    pMethods*: ptr UIAutomationMethodInfo
    cEvents*: UINT
    pEvents*: ptr UIAutomationEventInfo
    pPatternHandler*: ptr IUIAutomationPatternHandler
  TExtendedProperty* {.pure.} = object
    PropertyName*: BSTR
    PropertyValue*: BSTR
  UiaCondition* {.pure.} = object
    ConditionType*: ConditionType
  UiaPropertyCondition* {.pure.} = object
    ConditionType*: ConditionType
    PropertyId*: PROPERTYID
    Value*: VARIANT
    Flags*: PropertyConditionFlags
  UiaAndOrCondition* {.pure.} = object
    ConditionType*: ConditionType
    ppConditions*: ptr ptr UiaCondition
    cConditions*: int32
  UiaNotCondition* {.pure.} = object
    ConditionType*: ConditionType
    pCondition*: ptr UiaCondition
  UiaCacheRequest* {.pure.} = object
    pViewCondition*: ptr UiaCondition
    Scope*: TreeScope
    pProperties*: ptr PROPERTYID
    cProperties*: int32
    pPatterns*: ptr PATTERNID
    cPatterns*: int32
    automationElementMode*: AutomationElementMode
  UiaFindParams* {.pure.} = object
    MaxDepth*: int32
    FindFirst*: BOOL
    ExcludeRoot*: BOOL
    pFindCondition*: ptr UiaCondition
  UiaPropertyChangedEventArgs* {.pure.} = object
    Type*: EventArgsType
    EventId*: int32
    PropertyId*: PROPERTYID
    OldValue*: VARIANT
    NewValue*: VARIANT
  UiaStructureChangedEventArgs* {.pure.} = object
    Type*: EventArgsType
    EventId*: int32
    StructureChangeType*: StructureChangeType
    pRuntimeId*: ptr int32
    cRuntimeIdLen*: int32
  UiaTextEditTextChangedEventArgs* {.pure.} = object
    Type*: EventArgsType
    EventId*: int32
    TextEditChangeType*: TextEditChangeType
    pTextChange*: ptr SAFEARRAY
  UiaChangesEventArgs* {.pure.} = object
    Type*: EventArgsType
    EventId*: int32
    EventIdCount*: int32
    pUiaChanges*: ptr UiaChangeInfo
  UiaAsyncContentLoadedEventArgs* {.pure.} = object
    Type*: EventArgsType
    EventId*: int32
    AsyncContentLoadedState*: AsyncContentLoadedState
    PercentComplete*: float64
  UiaWindowClosedEventArgs* {.pure.} = object
    Type*: EventArgsType
    EventId*: int32
    pRuntimeId*: ptr int32
    cRuntimeIdLen*: int32
  IRawElementProviderSimple* {.pure.} = object
    lpVtbl*: ptr IRawElementProviderSimpleVtbl
  IRawElementProviderSimpleVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_ProviderOptions*: proc(self: ptr IRawElementProviderSimple, pRetVal: ptr ProviderOptions): HRESULT {.stdcall.}
    GetPatternProvider*: proc(self: ptr IRawElementProviderSimple, patternId: PATTERNID, pRetVal: ptr ptr IUnknown): HRESULT {.stdcall.}
    GetPropertyValue*: proc(self: ptr IRawElementProviderSimple, propertyId: PROPERTYID, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    get_HostRawElementProvider*: proc(self: ptr IRawElementProviderSimple, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
  IAccessibleEx* {.pure.} = object
    lpVtbl*: ptr IAccessibleExVtbl
  IAccessibleExVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetObjectForChild*: proc(self: ptr IAccessibleEx, idChild: int32, pRetVal: ptr ptr IAccessibleEx): HRESULT {.stdcall.}
    GetIAccessiblePair*: proc(self: ptr IAccessibleEx, ppAcc: ptr ptr IAccessible, pidChild: ptr int32): HRESULT {.stdcall.}
    GetRuntimeId*: proc(self: ptr IAccessibleEx, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    ConvertReturnedElement*: proc(self: ptr IAccessibleEx, pIn: ptr IRawElementProviderSimple, ppRetValOut: ptr ptr IAccessibleEx): HRESULT {.stdcall.}
  IRawElementProviderSimple2* {.pure.} = object
    lpVtbl*: ptr IRawElementProviderSimple2Vtbl
  IRawElementProviderSimple2Vtbl* {.pure, inheritable.} = object of IRawElementProviderSimpleVtbl
    ShowContextMenu*: proc(self: ptr IRawElementProviderSimple2): HRESULT {.stdcall.}
  IRawElementProviderSimple3* {.pure.} = object
    lpVtbl*: ptr IRawElementProviderSimple3Vtbl
  IRawElementProviderSimple3Vtbl* {.pure, inheritable.} = object of IRawElementProviderSimple2Vtbl
    GetMetadataValue*: proc(self: ptr IRawElementProviderSimple3, targetId: int32, metadataId: METADATAID, returnVal: ptr VARIANT): HRESULT {.stdcall.}
  IRawElementProviderFragment* {.pure.} = object
    lpVtbl*: ptr IRawElementProviderFragmentVtbl
  IRawElementProviderFragmentVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Navigate*: proc(self: ptr IRawElementProviderFragment, direction: NavigateDirection, pRetVal: ptr ptr IRawElementProviderFragment): HRESULT {.stdcall.}
    GetRuntimeId*: proc(self: ptr IRawElementProviderFragment, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_BoundingRectangle*: proc(self: ptr IRawElementProviderFragment, pRetVal: ptr UiaRect): HRESULT {.stdcall.}
    GetEmbeddedFragmentRoots*: proc(self: ptr IRawElementProviderFragment, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    SetFocus*: proc(self: ptr IRawElementProviderFragment): HRESULT {.stdcall.}
    get_FragmentRoot*: proc(self: ptr IRawElementProviderFragment, pRetVal: ptr ptr IRawElementProviderFragmentRoot): HRESULT {.stdcall.}
  IRawElementProviderFragmentRoot* {.pure.} = object
    lpVtbl*: ptr IRawElementProviderFragmentRootVtbl
  IRawElementProviderFragmentRootVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ElementProviderFromPoint*: proc(self: ptr IRawElementProviderFragmentRoot, x: float64, y: float64, pRetVal: ptr ptr IRawElementProviderFragment): HRESULT {.stdcall.}
    GetFocus*: proc(self: ptr IRawElementProviderFragmentRoot, pRetVal: ptr ptr IRawElementProviderFragment): HRESULT {.stdcall.}
  IRawElementProviderAdviseEvents* {.pure.} = object
    lpVtbl*: ptr IRawElementProviderAdviseEventsVtbl
  IRawElementProviderAdviseEventsVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AdviseEventAdded*: proc(self: ptr IRawElementProviderAdviseEvents, eventId: EVENTID, propertyIDs: ptr SAFEARRAY): HRESULT {.stdcall.}
    AdviseEventRemoved*: proc(self: ptr IRawElementProviderAdviseEvents, eventId: EVENTID, propertyIDs: ptr SAFEARRAY): HRESULT {.stdcall.}
  IRawElementProviderHwndOverride* {.pure.} = object
    lpVtbl*: ptr IRawElementProviderHwndOverrideVtbl
  IRawElementProviderHwndOverrideVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetOverrideProviderForHwnd*: proc(self: ptr IRawElementProviderHwndOverride, hwnd: HWND, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
  IProxyProviderWinEventSink* {.pure.} = object
    lpVtbl*: ptr IProxyProviderWinEventSinkVtbl
  IProxyProviderWinEventSinkVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddAutomationPropertyChangedEvent*: proc(self: ptr IProxyProviderWinEventSink, pProvider: ptr IRawElementProviderSimple, id: PROPERTYID, newValue: VARIANT): HRESULT {.stdcall.}
    AddAutomationEvent*: proc(self: ptr IProxyProviderWinEventSink, pProvider: ptr IRawElementProviderSimple, id: EVENTID): HRESULT {.stdcall.}
    AddStructureChangedEvent*: proc(self: ptr IProxyProviderWinEventSink, pProvider: ptr IRawElementProviderSimple, structureChangeType: StructureChangeType, runtimeId: ptr SAFEARRAY): HRESULT {.stdcall.}
  IProxyProviderWinEventHandler* {.pure.} = object
    lpVtbl*: ptr IProxyProviderWinEventHandlerVtbl
  IProxyProviderWinEventHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RespondToWinEvent*: proc(self: ptr IProxyProviderWinEventHandler, idWinEvent: DWORD, hwnd: HWND, idObject: LONG, idChild: LONG, pSink: ptr IProxyProviderWinEventSink): HRESULT {.stdcall.}
  IRawElementProviderWindowlessSite* {.pure.} = object
    lpVtbl*: ptr IRawElementProviderWindowlessSiteVtbl
  IRawElementProviderWindowlessSiteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetAdjacentFragment*: proc(self: ptr IRawElementProviderWindowlessSite, direction: NavigateDirection, ppParent: ptr ptr IRawElementProviderFragment): HRESULT {.stdcall.}
    GetRuntimeIdPrefix*: proc(self: ptr IRawElementProviderWindowlessSite, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  IAccessibleHostingElementProviders* {.pure.} = object
    lpVtbl*: ptr IAccessibleHostingElementProvidersVtbl
  IAccessibleHostingElementProvidersVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetEmbeddedFragmentRoots*: proc(self: ptr IAccessibleHostingElementProviders, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetObjectIdForProvider*: proc(self: ptr IAccessibleHostingElementProviders, pProvider: ptr IRawElementProviderSimple, pidObject: ptr int32): HRESULT {.stdcall.}
  IRawElementProviderHostingAccessibles* {.pure.} = object
    lpVtbl*: ptr IRawElementProviderHostingAccessiblesVtbl
  IRawElementProviderHostingAccessiblesVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetEmbeddedAccessibles*: proc(self: ptr IRawElementProviderHostingAccessibles, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  IDockProvider* {.pure.} = object
    lpVtbl*: ptr IDockProviderVtbl
  IDockProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetDockPosition*: proc(self: ptr IDockProvider, dockPosition: DockPosition): HRESULT {.stdcall.}
    get_DockPosition*: proc(self: ptr IDockProvider, pRetVal: ptr DockPosition): HRESULT {.stdcall.}
  IExpandCollapseProvider* {.pure.} = object
    lpVtbl*: ptr IExpandCollapseProviderVtbl
  IExpandCollapseProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Expand*: proc(self: ptr IExpandCollapseProvider): HRESULT {.stdcall.}
    Collapse*: proc(self: ptr IExpandCollapseProvider): HRESULT {.stdcall.}
    get_ExpandCollapseState*: proc(self: ptr IExpandCollapseProvider, pRetVal: ptr ExpandCollapseState): HRESULT {.stdcall.}
  IGridProvider* {.pure.} = object
    lpVtbl*: ptr IGridProviderVtbl
  IGridProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetItem*: proc(self: ptr IGridProvider, row: int32, column: int32, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
    get_RowCount*: proc(self: ptr IGridProvider, pRetVal: ptr int32): HRESULT {.stdcall.}
    get_ColumnCount*: proc(self: ptr IGridProvider, pRetVal: ptr int32): HRESULT {.stdcall.}
  IGridItemProvider* {.pure.} = object
    lpVtbl*: ptr IGridItemProviderVtbl
  IGridItemProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_Row*: proc(self: ptr IGridItemProvider, pRetVal: ptr int32): HRESULT {.stdcall.}
    get_Column*: proc(self: ptr IGridItemProvider, pRetVal: ptr int32): HRESULT {.stdcall.}
    get_RowSpan*: proc(self: ptr IGridItemProvider, pRetVal: ptr int32): HRESULT {.stdcall.}
    get_ColumnSpan*: proc(self: ptr IGridItemProvider, pRetVal: ptr int32): HRESULT {.stdcall.}
    get_ContainingGrid*: proc(self: ptr IGridItemProvider, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
  IInvokeProvider* {.pure.} = object
    lpVtbl*: ptr IInvokeProviderVtbl
  IInvokeProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Invoke*: proc(self: ptr IInvokeProvider): HRESULT {.stdcall.}
  IMultipleViewProvider* {.pure.} = object
    lpVtbl*: ptr IMultipleViewProviderVtbl
  IMultipleViewProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetViewName*: proc(self: ptr IMultipleViewProvider, viewId: int32, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    SetCurrentView*: proc(self: ptr IMultipleViewProvider, viewId: int32): HRESULT {.stdcall.}
    get_CurrentView*: proc(self: ptr IMultipleViewProvider, pRetVal: ptr int32): HRESULT {.stdcall.}
    GetSupportedViews*: proc(self: ptr IMultipleViewProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  IRangeValueProvider* {.pure.} = object
    lpVtbl*: ptr IRangeValueProviderVtbl
  IRangeValueProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetValue*: proc(self: ptr IRangeValueProvider, val: float64): HRESULT {.stdcall.}
    get_Value*: proc(self: ptr IRangeValueProvider, pRetVal: ptr float64): HRESULT {.stdcall.}
    get_IsReadOnly*: proc(self: ptr IRangeValueProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    get_Maximum*: proc(self: ptr IRangeValueProvider, pRetVal: ptr float64): HRESULT {.stdcall.}
    get_Minimum*: proc(self: ptr IRangeValueProvider, pRetVal: ptr float64): HRESULT {.stdcall.}
    get_LargeChange*: proc(self: ptr IRangeValueProvider, pRetVal: ptr float64): HRESULT {.stdcall.}
    get_SmallChange*: proc(self: ptr IRangeValueProvider, pRetVal: ptr float64): HRESULT {.stdcall.}
  IScrollItemProvider* {.pure.} = object
    lpVtbl*: ptr IScrollItemProviderVtbl
  IScrollItemProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ScrollIntoView*: proc(self: ptr IScrollItemProvider): HRESULT {.stdcall.}
  ISelectionProvider* {.pure.} = object
    lpVtbl*: ptr ISelectionProviderVtbl
  ISelectionProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetSelection*: proc(self: ptr ISelectionProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_CanSelectMultiple*: proc(self: ptr ISelectionProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    get_IsSelectionRequired*: proc(self: ptr ISelectionProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
  ISelectionProvider2* {.pure.} = object
    lpVtbl*: ptr ISelectionProvider2Vtbl
  ISelectionProvider2Vtbl* {.pure, inheritable.} = object of ISelectionProviderVtbl
    get_FirstSelectedItem*: proc(self: ptr ISelectionProvider2, retVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
    get_LastSelectedItem*: proc(self: ptr ISelectionProvider2, retVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
    get_CurrentSelectedItem*: proc(self: ptr ISelectionProvider2, retVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
    get_ItemCount*: proc(self: ptr ISelectionProvider2, retVal: ptr int32): HRESULT {.stdcall.}
  IScrollProvider* {.pure.} = object
    lpVtbl*: ptr IScrollProviderVtbl
  IScrollProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Scroll*: proc(self: ptr IScrollProvider, horizontalAmount: ScrollAmount, verticalAmount: ScrollAmount): HRESULT {.stdcall.}
    SetScrollPercent*: proc(self: ptr IScrollProvider, horizontalPercent: float64, verticalPercent: float64): HRESULT {.stdcall.}
    get_HorizontalScrollPercent*: proc(self: ptr IScrollProvider, pRetVal: ptr float64): HRESULT {.stdcall.}
    get_VerticalScrollPercent*: proc(self: ptr IScrollProvider, pRetVal: ptr float64): HRESULT {.stdcall.}
    get_HorizontalViewSize*: proc(self: ptr IScrollProvider, pRetVal: ptr float64): HRESULT {.stdcall.}
    get_VerticalViewSize*: proc(self: ptr IScrollProvider, pRetVal: ptr float64): HRESULT {.stdcall.}
    get_HorizontallyScrollable*: proc(self: ptr IScrollProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    get_VerticallyScrollable*: proc(self: ptr IScrollProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
  ISelectionItemProvider* {.pure.} = object
    lpVtbl*: ptr ISelectionItemProviderVtbl
  ISelectionItemProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Select*: proc(self: ptr ISelectionItemProvider): HRESULT {.stdcall.}
    AddToSelection*: proc(self: ptr ISelectionItemProvider): HRESULT {.stdcall.}
    RemoveFromSelection*: proc(self: ptr ISelectionItemProvider): HRESULT {.stdcall.}
    get_IsSelected*: proc(self: ptr ISelectionItemProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    get_SelectionContainer*: proc(self: ptr ISelectionItemProvider, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
  ISynchronizedInputProvider* {.pure.} = object
    lpVtbl*: ptr ISynchronizedInputProviderVtbl
  ISynchronizedInputProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    StartListening*: proc(self: ptr ISynchronizedInputProvider, inputType: SynchronizedInputType): HRESULT {.stdcall.}
    Cancel*: proc(self: ptr ISynchronizedInputProvider): HRESULT {.stdcall.}
  ITableProvider* {.pure.} = object
    lpVtbl*: ptr ITableProviderVtbl
  ITableProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetRowHeaders*: proc(self: ptr ITableProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetColumnHeaders*: proc(self: ptr ITableProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_RowOrColumnMajor*: proc(self: ptr ITableProvider, pRetVal: ptr RowOrColumnMajor): HRESULT {.stdcall.}
  ITableItemProvider* {.pure.} = object
    lpVtbl*: ptr ITableItemProviderVtbl
  ITableItemProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetRowHeaderItems*: proc(self: ptr ITableItemProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetColumnHeaderItems*: proc(self: ptr ITableItemProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  IToggleProvider* {.pure.} = object
    lpVtbl*: ptr IToggleProviderVtbl
  IToggleProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Toggle*: proc(self: ptr IToggleProvider): HRESULT {.stdcall.}
    get_ToggleState*: proc(self: ptr IToggleProvider, pRetVal: ptr ToggleState): HRESULT {.stdcall.}
  ITransformProvider* {.pure.} = object
    lpVtbl*: ptr ITransformProviderVtbl
  ITransformProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Move*: proc(self: ptr ITransformProvider, x: float64, y: float64): HRESULT {.stdcall.}
    Resize*: proc(self: ptr ITransformProvider, width: float64, height: float64): HRESULT {.stdcall.}
    Rotate*: proc(self: ptr ITransformProvider, degrees: float64): HRESULT {.stdcall.}
    get_CanMove*: proc(self: ptr ITransformProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    get_CanResize*: proc(self: ptr ITransformProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    get_CanRotate*: proc(self: ptr ITransformProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
  IValueProvider* {.pure.} = object
    lpVtbl*: ptr IValueProviderVtbl
  IValueProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetValue*: proc(self: ptr IValueProvider, val: LPCWSTR): HRESULT {.stdcall.}
    get_Value*: proc(self: ptr IValueProvider, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    get_IsReadOnly*: proc(self: ptr IValueProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
  IWindowProvider* {.pure.} = object
    lpVtbl*: ptr IWindowProviderVtbl
  IWindowProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetVisualState*: proc(self: ptr IWindowProvider, state: WindowVisualState): HRESULT {.stdcall.}
    Close*: proc(self: ptr IWindowProvider): HRESULT {.stdcall.}
    WaitForInputIdle*: proc(self: ptr IWindowProvider, milliseconds: int32, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    get_CanMaximize*: proc(self: ptr IWindowProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    get_CanMinimize*: proc(self: ptr IWindowProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    get_IsModal*: proc(self: ptr IWindowProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    get_WindowVisualState*: proc(self: ptr IWindowProvider, pRetVal: ptr WindowVisualState): HRESULT {.stdcall.}
    get_WindowInteractionState*: proc(self: ptr IWindowProvider, pRetVal: ptr WindowInteractionState): HRESULT {.stdcall.}
    get_IsTopmost*: proc(self: ptr IWindowProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
  ILegacyIAccessibleProvider* {.pure.} = object
    lpVtbl*: ptr ILegacyIAccessibleProviderVtbl
  ILegacyIAccessibleProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Select*: proc(self: ptr ILegacyIAccessibleProvider, flagsSelect: int32): HRESULT {.stdcall.}
    DoDefaultAction*: proc(self: ptr ILegacyIAccessibleProvider): HRESULT {.stdcall.}
    SetValue*: proc(self: ptr ILegacyIAccessibleProvider, szValue: LPCWSTR): HRESULT {.stdcall.}
    GetIAccessible*: proc(self: ptr ILegacyIAccessibleProvider, ppAccessible: ptr ptr IAccessible): HRESULT {.stdcall.}
    get_ChildId*: proc(self: ptr ILegacyIAccessibleProvider, pRetVal: ptr int32): HRESULT {.stdcall.}
    get_Name*: proc(self: ptr ILegacyIAccessibleProvider, pszName: ptr BSTR): HRESULT {.stdcall.}
    get_Value*: proc(self: ptr ILegacyIAccessibleProvider, pszValue: ptr BSTR): HRESULT {.stdcall.}
    get_Description*: proc(self: ptr ILegacyIAccessibleProvider, pszDescription: ptr BSTR): HRESULT {.stdcall.}
    get_Role*: proc(self: ptr ILegacyIAccessibleProvider, pdwRole: ptr DWORD): HRESULT {.stdcall.}
    get_State*: proc(self: ptr ILegacyIAccessibleProvider, pdwState: ptr DWORD): HRESULT {.stdcall.}
    get_Help*: proc(self: ptr ILegacyIAccessibleProvider, pszHelp: ptr BSTR): HRESULT {.stdcall.}
    get_KeyboardShortcut*: proc(self: ptr ILegacyIAccessibleProvider, pszKeyboardShortcut: ptr BSTR): HRESULT {.stdcall.}
    GetSelection*: proc(self: ptr ILegacyIAccessibleProvider, pvarSelectedChildren: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_DefaultAction*: proc(self: ptr ILegacyIAccessibleProvider, pszDefaultAction: ptr BSTR): HRESULT {.stdcall.}
  IItemContainerProvider* {.pure.} = object
    lpVtbl*: ptr IItemContainerProviderVtbl
  IItemContainerProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    FindItemByProperty*: proc(self: ptr IItemContainerProvider, pStartAfter: ptr IRawElementProviderSimple, propertyId: PROPERTYID, value: VARIANT, pFound: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
  IVirtualizedItemProvider* {.pure.} = object
    lpVtbl*: ptr IVirtualizedItemProviderVtbl
  IVirtualizedItemProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Realize*: proc(self: ptr IVirtualizedItemProvider): HRESULT {.stdcall.}
  IObjectModelProvider* {.pure.} = object
    lpVtbl*: ptr IObjectModelProviderVtbl
  IObjectModelProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetUnderlyingObjectModel*: proc(self: ptr IObjectModelProvider, ppUnknown: ptr ptr IUnknown): HRESULT {.stdcall.}
  IAnnotationProvider* {.pure.} = object
    lpVtbl*: ptr IAnnotationProviderVtbl
  IAnnotationProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_AnnotationTypeId*: proc(self: ptr IAnnotationProvider, retVal: ptr int32): HRESULT {.stdcall.}
    get_AnnotationTypeName*: proc(self: ptr IAnnotationProvider, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_Author*: proc(self: ptr IAnnotationProvider, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_DateTime*: proc(self: ptr IAnnotationProvider, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_Target*: proc(self: ptr IAnnotationProvider, retVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
  IStylesProvider* {.pure.} = object
    lpVtbl*: ptr IStylesProviderVtbl
  IStylesProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_StyleId*: proc(self: ptr IStylesProvider, retVal: ptr int32): HRESULT {.stdcall.}
    get_StyleName*: proc(self: ptr IStylesProvider, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_FillColor*: proc(self: ptr IStylesProvider, retVal: ptr int32): HRESULT {.stdcall.}
    get_FillPatternStyle*: proc(self: ptr IStylesProvider, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_Shape*: proc(self: ptr IStylesProvider, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_FillPatternColor*: proc(self: ptr IStylesProvider, retVal: ptr int32): HRESULT {.stdcall.}
    get_ExtendedProperties*: proc(self: ptr IStylesProvider, retVal: ptr BSTR): HRESULT {.stdcall.}
  ISpreadsheetProvider* {.pure.} = object
    lpVtbl*: ptr ISpreadsheetProviderVtbl
  ISpreadsheetProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetItemByName*: proc(self: ptr ISpreadsheetProvider, name: LPCWSTR, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
  ISpreadsheetItemProvider* {.pure.} = object
    lpVtbl*: ptr ISpreadsheetItemProviderVtbl
  ISpreadsheetItemProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_Formula*: proc(self: ptr ISpreadsheetItemProvider, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    GetAnnotationObjects*: proc(self: ptr ISpreadsheetItemProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetAnnotationTypes*: proc(self: ptr ISpreadsheetItemProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  ITransformProvider2* {.pure.} = object
    lpVtbl*: ptr ITransformProvider2Vtbl
  ITransformProvider2Vtbl* {.pure, inheritable.} = object of ITransformProviderVtbl
    Zoom*: proc(self: ptr ITransformProvider2, zoom: float64): HRESULT {.stdcall.}
    get_CanZoom*: proc(self: ptr ITransformProvider2, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    get_ZoomLevel*: proc(self: ptr ITransformProvider2, pRetVal: ptr float64): HRESULT {.stdcall.}
    get_ZoomMinimum*: proc(self: ptr ITransformProvider2, pRetVal: ptr float64): HRESULT {.stdcall.}
    get_ZoomMaximum*: proc(self: ptr ITransformProvider2, pRetVal: ptr float64): HRESULT {.stdcall.}
    ZoomByUnit*: proc(self: ptr ITransformProvider2, zoomUnit: ZoomUnit): HRESULT {.stdcall.}
  IDragProvider* {.pure.} = object
    lpVtbl*: ptr IDragProviderVtbl
  IDragProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_IsGrabbed*: proc(self: ptr IDragProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    get_DropEffect*: proc(self: ptr IDragProvider, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    get_DropEffects*: proc(self: ptr IDragProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetGrabbedItems*: proc(self: ptr IDragProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  IDropTargetProvider* {.pure.} = object
    lpVtbl*: ptr IDropTargetProviderVtbl
  IDropTargetProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_DropTargetEffect*: proc(self: ptr IDropTargetProvider, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    get_DropTargetEffects*: proc(self: ptr IDropTargetProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  ITextRangeProvider* {.pure.} = object
    lpVtbl*: ptr ITextRangeProviderVtbl
  ITextRangeProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Clone*: proc(self: ptr ITextRangeProvider, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.stdcall.}
    Compare*: proc(self: ptr ITextRangeProvider, range: ptr ITextRangeProvider, pRetVal: ptr BOOL): HRESULT {.stdcall.}
    CompareEndpoints*: proc(self: ptr ITextRangeProvider, endpoint: TextPatternRangeEndpoint, targetRange: ptr ITextRangeProvider, targetEndpoint: TextPatternRangeEndpoint, pRetVal: ptr int32): HRESULT {.stdcall.}
    ExpandToEnclosingUnit*: proc(self: ptr ITextRangeProvider, unit: TextUnit): HRESULT {.stdcall.}
    FindAttribute*: proc(self: ptr ITextRangeProvider, attributeId: TEXTATTRIBUTEID, val: VARIANT, backward: BOOL, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.stdcall.}
    FindText*: proc(self: ptr ITextRangeProvider, text: BSTR, backward: BOOL, ignoreCase: BOOL, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.stdcall.}
    GetAttributeValue*: proc(self: ptr ITextRangeProvider, attributeId: TEXTATTRIBUTEID, pRetVal: ptr VARIANT): HRESULT {.stdcall.}
    GetBoundingRectangles*: proc(self: ptr ITextRangeProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetEnclosingElement*: proc(self: ptr ITextRangeProvider, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
    GetText*: proc(self: ptr ITextRangeProvider, maxLength: int32, pRetVal: ptr BSTR): HRESULT {.stdcall.}
    Move*: proc(self: ptr ITextRangeProvider, unit: TextUnit, count: int32, pRetVal: ptr int32): HRESULT {.stdcall.}
    MoveEndpointByUnit*: proc(self: ptr ITextRangeProvider, endpoint: TextPatternRangeEndpoint, unit: TextUnit, count: int32, pRetVal: ptr int32): HRESULT {.stdcall.}
    MoveEndpointByRange*: proc(self: ptr ITextRangeProvider, endpoint: TextPatternRangeEndpoint, targetRange: ptr ITextRangeProvider, targetEndpoint: TextPatternRangeEndpoint): HRESULT {.stdcall.}
    Select*: proc(self: ptr ITextRangeProvider): HRESULT {.stdcall.}
    AddToSelection*: proc(self: ptr ITextRangeProvider): HRESULT {.stdcall.}
    RemoveFromSelection*: proc(self: ptr ITextRangeProvider): HRESULT {.stdcall.}
    ScrollIntoView*: proc(self: ptr ITextRangeProvider, alignToTop: BOOL): HRESULT {.stdcall.}
    GetChildren*: proc(self: ptr ITextRangeProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  ITextProvider* {.pure.} = object
    lpVtbl*: ptr ITextProviderVtbl
  ITextProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetSelection*: proc(self: ptr ITextProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetVisibleRanges*: proc(self: ptr ITextProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    RangeFromChild*: proc(self: ptr ITextProvider, childElement: ptr IRawElementProviderSimple, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.stdcall.}
    RangeFromPoint*: proc(self: ptr ITextProvider, point: UiaPoint, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.stdcall.}
    get_DocumentRange*: proc(self: ptr ITextProvider, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.stdcall.}
    get_SupportedTextSelection*: proc(self: ptr ITextProvider, pRetVal: ptr SupportedTextSelection): HRESULT {.stdcall.}
  ITextProvider2* {.pure.} = object
    lpVtbl*: ptr ITextProvider2Vtbl
  ITextProvider2Vtbl* {.pure, inheritable.} = object of ITextProviderVtbl
    RangeFromAnnotation*: proc(self: ptr ITextProvider2, annotationElement: ptr IRawElementProviderSimple, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.stdcall.}
    GetCaretRange*: proc(self: ptr ITextProvider2, isActive: ptr BOOL, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.stdcall.}
  ITextEditProvider* {.pure.} = object
    lpVtbl*: ptr ITextEditProviderVtbl
  ITextEditProviderVtbl* {.pure, inheritable.} = object of ITextProviderVtbl
    GetActiveComposition*: proc(self: ptr ITextEditProvider, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.stdcall.}
    GetConversionTarget*: proc(self: ptr ITextEditProvider, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.stdcall.}
  ITextRangeProvider2* {.pure.} = object
    lpVtbl*: ptr ITextRangeProvider2Vtbl
  ITextRangeProvider2Vtbl* {.pure, inheritable.} = object of ITextRangeProviderVtbl
    ShowContextMenu*: proc(self: ptr ITextRangeProvider2): HRESULT {.stdcall.}
  ITextChildProvider* {.pure.} = object
    lpVtbl*: ptr ITextChildProviderVtbl
  ITextChildProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_TextContainer*: proc(self: ptr ITextChildProvider, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
    get_TextRange*: proc(self: ptr ITextChildProvider, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.stdcall.}
  ICustomNavigationProvider* {.pure.} = object
    lpVtbl*: ptr ICustomNavigationProviderVtbl
  ICustomNavigationProviderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Navigate*: proc(self: ptr ICustomNavigationProvider, direction: NavigateDirection, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
  IUIAutomationRegistrar* {.pure.} = object
    lpVtbl*: ptr IUIAutomationRegistrarVtbl
  IUIAutomationRegistrarVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RegisterProperty*: proc(self: ptr IUIAutomationRegistrar, property: ptr UIAutomationPropertyInfo, propertyId: ptr PROPERTYID): HRESULT {.stdcall.}
    RegisterEvent*: proc(self: ptr IUIAutomationRegistrar, event: ptr UIAutomationEventInfo, eventId: ptr EVENTID): HRESULT {.stdcall.}
    RegisterPattern*: proc(self: ptr IUIAutomationRegistrar, pattern: ptr UIAutomationPatternInfo, pPatternId: ptr PATTERNID, pPatternAvailablePropertyId: ptr PROPERTYID, propertyIdCount: UINT, pPropertyIds: ptr PROPERTYID, eventIdCount: UINT, pEventIds: ptr EVENTID): HRESULT {.stdcall.}
  IUIAutomationCondition* {.pure.} = object
    lpVtbl*: ptr IUIAutomationConditionVtbl
  IUIAutomationConditionVtbl* {.pure, inheritable.} = object of IUnknownVtbl
  IUIAutomationElementArray* {.pure.} = object
    lpVtbl*: ptr IUIAutomationElementArrayVtbl
  IUIAutomationElementArrayVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_Length*: proc(self: ptr IUIAutomationElementArray, length: ptr int32): HRESULT {.stdcall.}
    GetElement*: proc(self: ptr IUIAutomationElementArray, index: int32, element: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
  IUIAutomationCacheRequest* {.pure.} = object
    lpVtbl*: ptr IUIAutomationCacheRequestVtbl
  IUIAutomationCacheRequestVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddProperty*: proc(self: ptr IUIAutomationCacheRequest, propertyId: PROPERTYID): HRESULT {.stdcall.}
    AddPattern*: proc(self: ptr IUIAutomationCacheRequest, patternId: PATTERNID): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IUIAutomationCacheRequest, clonedRequest: ptr ptr IUIAutomationCacheRequest): HRESULT {.stdcall.}
    get_TreeScope*: proc(self: ptr IUIAutomationCacheRequest, scope: ptr TreeScope): HRESULT {.stdcall.}
    put_TreeScope*: proc(self: ptr IUIAutomationCacheRequest, scope: TreeScope): HRESULT {.stdcall.}
    get_TreeFilter*: proc(self: ptr IUIAutomationCacheRequest, filter: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    put_TreeFilter*: proc(self: ptr IUIAutomationCacheRequest, filter: ptr IUIAutomationCondition): HRESULT {.stdcall.}
    get_AutomationElementMode*: proc(self: ptr IUIAutomationCacheRequest, mode: ptr AutomationElementMode): HRESULT {.stdcall.}
    put_AutomationElementMode*: proc(self: ptr IUIAutomationCacheRequest, mode: AutomationElementMode): HRESULT {.stdcall.}
  IUIAutomationElement* {.pure.} = object
    lpVtbl*: ptr IUIAutomationElementVtbl
  IUIAutomationElementVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetFocus*: proc(self: ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetRuntimeId*: proc(self: ptr IUIAutomationElement, runtimeId: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    FindFirst*: proc(self: ptr IUIAutomationElement, scope: TreeScope, condition: ptr IUIAutomationCondition, found: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    FindAll*: proc(self: ptr IUIAutomationElement, scope: TreeScope, condition: ptr IUIAutomationCondition, found: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    FindFirstBuildCache*: proc(self: ptr IUIAutomationElement, scope: TreeScope, condition: ptr IUIAutomationCondition, cacheRequest: ptr IUIAutomationCacheRequest, found: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    FindAllBuildCache*: proc(self: ptr IUIAutomationElement, scope: TreeScope, condition: ptr IUIAutomationCondition, cacheRequest: ptr IUIAutomationCacheRequest, found: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    BuildUpdatedCache*: proc(self: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, updatedElement: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetCurrentPropertyValue*: proc(self: ptr IUIAutomationElement, propertyId: PROPERTYID, retVal: ptr VARIANT): HRESULT {.stdcall.}
    GetCurrentPropertyValueEx*: proc(self: ptr IUIAutomationElement, propertyId: PROPERTYID, ignoreDefaultValue: BOOL, retVal: ptr VARIANT): HRESULT {.stdcall.}
    GetCachedPropertyValue*: proc(self: ptr IUIAutomationElement, propertyId: PROPERTYID, retVal: ptr VARIANT): HRESULT {.stdcall.}
    GetCachedPropertyValueEx*: proc(self: ptr IUIAutomationElement, propertyId: PROPERTYID, ignoreDefaultValue: BOOL, retVal: ptr VARIANT): HRESULT {.stdcall.}
    GetCurrentPatternAs*: proc(self: ptr IUIAutomationElement, patternId: PATTERNID, riid: REFIID, patternObject: ptr pointer): HRESULT {.stdcall.}
    GetCachedPatternAs*: proc(self: ptr IUIAutomationElement, patternId: PATTERNID, riid: REFIID, patternObject: ptr pointer): HRESULT {.stdcall.}
    GetCurrentPattern*: proc(self: ptr IUIAutomationElement, patternId: PATTERNID, patternObject: ptr ptr IUnknown): HRESULT {.stdcall.}
    GetCachedPattern*: proc(self: ptr IUIAutomationElement, patternId: PATTERNID, patternObject: ptr ptr IUnknown): HRESULT {.stdcall.}
    GetCachedParent*: proc(self: ptr IUIAutomationElement, parent: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetCachedChildren*: proc(self: ptr IUIAutomationElement, children: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CurrentProcessId*: proc(self: ptr IUIAutomationElement, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentControlType*: proc(self: ptr IUIAutomationElement, retVal: ptr CONTROLTYPEID): HRESULT {.stdcall.}
    get_CurrentLocalizedControlType*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentName*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentAcceleratorKey*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentAccessKey*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentHasKeyboardFocus*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentIsKeyboardFocusable*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentIsEnabled*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentAutomationId*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentClassName*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentHelpText*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentCulture*: proc(self: ptr IUIAutomationElement, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentIsControlElement*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentIsContentElement*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentIsPassword*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentNativeWindowHandle*: proc(self: ptr IUIAutomationElement, retVal: ptr UIA_HWND): HRESULT {.stdcall.}
    get_CurrentItemType*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentIsOffscreen*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentOrientation*: proc(self: ptr IUIAutomationElement, retVal: ptr OrientationType): HRESULT {.stdcall.}
    get_CurrentFrameworkId*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentIsRequiredForForm*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentItemStatus*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentBoundingRectangle*: proc(self: ptr IUIAutomationElement, retVal: ptr RECT): HRESULT {.stdcall.}
    get_CurrentLabeledBy*: proc(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CurrentAriaRole*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentAriaProperties*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentIsDataValidForForm*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentControllerFor*: proc(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CurrentDescribedBy*: proc(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CurrentFlowsTo*: proc(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CurrentProviderDescription*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedProcessId*: proc(self: ptr IUIAutomationElement, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedControlType*: proc(self: ptr IUIAutomationElement, retVal: ptr CONTROLTYPEID): HRESULT {.stdcall.}
    get_CachedLocalizedControlType*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedName*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedAcceleratorKey*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedAccessKey*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedHasKeyboardFocus*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedIsKeyboardFocusable*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedIsEnabled*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedAutomationId*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedClassName*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedHelpText*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedCulture*: proc(self: ptr IUIAutomationElement, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedIsControlElement*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedIsContentElement*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedIsPassword*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedNativeWindowHandle*: proc(self: ptr IUIAutomationElement, retVal: ptr UIA_HWND): HRESULT {.stdcall.}
    get_CachedItemType*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedIsOffscreen*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedOrientation*: proc(self: ptr IUIAutomationElement, retVal: ptr OrientationType): HRESULT {.stdcall.}
    get_CachedFrameworkId*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedIsRequiredForForm*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedItemStatus*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedBoundingRectangle*: proc(self: ptr IUIAutomationElement, retVal: ptr RECT): HRESULT {.stdcall.}
    get_CachedLabeledBy*: proc(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CachedAriaRole*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedAriaProperties*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedIsDataValidForForm*: proc(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedControllerFor*: proc(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CachedDescribedBy*: proc(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CachedFlowsTo*: proc(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CachedProviderDescription*: proc(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.stdcall.}
    GetClickablePoint*: proc(self: ptr IUIAutomationElement, clickable: ptr POINT, gotClickable: ptr BOOL): HRESULT {.stdcall.}
  IUIAutomationBoolCondition* {.pure.} = object
    lpVtbl*: ptr IUIAutomationBoolConditionVtbl
  IUIAutomationBoolConditionVtbl* {.pure, inheritable.} = object of IUIAutomationConditionVtbl
    get_BooleanValue*: proc(self: ptr IUIAutomationBoolCondition, boolVal: ptr BOOL): HRESULT {.stdcall.}
  IUIAutomationPropertyCondition* {.pure.} = object
    lpVtbl*: ptr IUIAutomationPropertyConditionVtbl
  IUIAutomationPropertyConditionVtbl* {.pure, inheritable.} = object of IUIAutomationConditionVtbl
    get_PropertyId*: proc(self: ptr IUIAutomationPropertyCondition, propertyId: ptr PROPERTYID): HRESULT {.stdcall.}
    get_PropertyValue*: proc(self: ptr IUIAutomationPropertyCondition, propertyValue: ptr VARIANT): HRESULT {.stdcall.}
    get_PropertyConditionFlags*: proc(self: ptr IUIAutomationPropertyCondition, flags: ptr PropertyConditionFlags): HRESULT {.stdcall.}
  IUIAutomationAndCondition* {.pure.} = object
    lpVtbl*: ptr IUIAutomationAndConditionVtbl
  IUIAutomationAndConditionVtbl* {.pure, inheritable.} = object of IUIAutomationConditionVtbl
    get_ChildCount*: proc(self: ptr IUIAutomationAndCondition, childCount: ptr int32): HRESULT {.stdcall.}
    GetChildrenAsNativeArray*: proc(self: ptr IUIAutomationAndCondition, childArray: ptr ptr ptr IUIAutomationCondition, childArrayCount: ptr int32): HRESULT {.stdcall.}
    GetChildren*: proc(self: ptr IUIAutomationAndCondition, childArray: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  IUIAutomationOrCondition* {.pure.} = object
    lpVtbl*: ptr IUIAutomationOrConditionVtbl
  IUIAutomationOrConditionVtbl* {.pure, inheritable.} = object of IUIAutomationConditionVtbl
    get_ChildCount*: proc(self: ptr IUIAutomationOrCondition, childCount: ptr int32): HRESULT {.stdcall.}
    GetChildrenAsNativeArray*: proc(self: ptr IUIAutomationOrCondition, childArray: ptr ptr ptr IUIAutomationCondition, childArrayCount: ptr int32): HRESULT {.stdcall.}
    GetChildren*: proc(self: ptr IUIAutomationOrCondition, childArray: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  IUIAutomationNotCondition* {.pure.} = object
    lpVtbl*: ptr IUIAutomationNotConditionVtbl
  IUIAutomationNotConditionVtbl* {.pure, inheritable.} = object of IUIAutomationConditionVtbl
    GetChild*: proc(self: ptr IUIAutomationNotCondition, condition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
  IUIAutomationTreeWalker* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTreeWalkerVtbl
  IUIAutomationTreeWalkerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetParentElement*: proc(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, parent: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetFirstChildElement*: proc(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, first: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetLastChildElement*: proc(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, last: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetNextSiblingElement*: proc(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, next: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetPreviousSiblingElement*: proc(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, previous: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    NormalizeElement*: proc(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, normalized: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetParentElementBuildCache*: proc(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, parent: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetFirstChildElementBuildCache*: proc(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, first: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetLastChildElementBuildCache*: proc(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, last: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetNextSiblingElementBuildCache*: proc(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, next: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetPreviousSiblingElementBuildCache*: proc(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, previous: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    NormalizeElementBuildCache*: proc(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, normalized: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_Condition*: proc(self: ptr IUIAutomationTreeWalker, condition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
  IUIAutomationEventHandler* {.pure.} = object
    lpVtbl*: ptr IUIAutomationEventHandlerVtbl
  IUIAutomationEventHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    HandleAutomationEvent*: proc(self: ptr IUIAutomationEventHandler, sender: ptr IUIAutomationElement, eventId: EVENTID): HRESULT {.stdcall.}
  IUIAutomationPropertyChangedEventHandler* {.pure.} = object
    lpVtbl*: ptr IUIAutomationPropertyChangedEventHandlerVtbl
  IUIAutomationPropertyChangedEventHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    HandlePropertyChangedEvent*: proc(self: ptr IUIAutomationPropertyChangedEventHandler, sender: ptr IUIAutomationElement, propertyId: PROPERTYID, newValue: VARIANT): HRESULT {.stdcall.}
  IUIAutomationStructureChangedEventHandler* {.pure.} = object
    lpVtbl*: ptr IUIAutomationStructureChangedEventHandlerVtbl
  IUIAutomationStructureChangedEventHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    HandleStructureChangedEvent*: proc(self: ptr IUIAutomationStructureChangedEventHandler, sender: ptr IUIAutomationElement, changeType: StructureChangeType, runtimeId: ptr SAFEARRAY): HRESULT {.stdcall.}
  IUIAutomationFocusChangedEventHandler* {.pure.} = object
    lpVtbl*: ptr IUIAutomationFocusChangedEventHandlerVtbl
  IUIAutomationFocusChangedEventHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    HandleFocusChangedEvent*: proc(self: ptr IUIAutomationFocusChangedEventHandler, sender: ptr IUIAutomationElement): HRESULT {.stdcall.}
  IUIAutomationTextEditTextChangedEventHandler* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTextEditTextChangedEventHandlerVtbl
  IUIAutomationTextEditTextChangedEventHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    HandleTextEditTextChangedEvent*: proc(self: ptr IUIAutomationTextEditTextChangedEventHandler, sender: ptr IUIAutomationElement, textEditChangeType: TextEditChangeType, eventStrings: ptr SAFEARRAY): HRESULT {.stdcall.}
  IUIAutomationChangesEventHandler* {.pure.} = object
    lpVtbl*: ptr IUIAutomationChangesEventHandlerVtbl
  IUIAutomationChangesEventHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    HandleChangesEvent*: proc(self: ptr IUIAutomationChangesEventHandler, sender: ptr IUIAutomationElement, uiaChanges: ptr UiaChangeInfo, changesCount: int32): HRESULT {.stdcall.}
  IUIAutomationNotificationEventHandler* {.pure.} = object
    lpVtbl*: ptr IUIAutomationNotificationEventHandlerVtbl
  IUIAutomationNotificationEventHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    HandleNotificationEvent*: proc(self: ptr IUIAutomationNotificationEventHandler, sender: ptr IUIAutomationElement, notificationKind: NotificationKind, notificationProcessing: NotificationProcessing, displayString: BSTR, activityId: BSTR): HRESULT {.stdcall.}
  IUIAutomationInvokePattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationInvokePatternVtbl
  IUIAutomationInvokePatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Invoke*: proc(self: ptr IUIAutomationInvokePattern): HRESULT {.stdcall.}
  IUIAutomationDockPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationDockPatternVtbl
  IUIAutomationDockPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetDockPosition*: proc(self: ptr IUIAutomationDockPattern, dockPos: DockPosition): HRESULT {.stdcall.}
    get_CurrentDockPosition*: proc(self: ptr IUIAutomationDockPattern, retVal: ptr DockPosition): HRESULT {.stdcall.}
    get_CachedDockPosition*: proc(self: ptr IUIAutomationDockPattern, retVal: ptr DockPosition): HRESULT {.stdcall.}
  IUIAutomationExpandCollapsePattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationExpandCollapsePatternVtbl
  IUIAutomationExpandCollapsePatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Expand*: proc(self: ptr IUIAutomationExpandCollapsePattern): HRESULT {.stdcall.}
    Collapse*: proc(self: ptr IUIAutomationExpandCollapsePattern): HRESULT {.stdcall.}
    get_CurrentExpandCollapseState*: proc(self: ptr IUIAutomationExpandCollapsePattern, retVal: ptr ExpandCollapseState): HRESULT {.stdcall.}
    get_CachedExpandCollapseState*: proc(self: ptr IUIAutomationExpandCollapsePattern, retVal: ptr ExpandCollapseState): HRESULT {.stdcall.}
  IUIAutomationGridPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationGridPatternVtbl
  IUIAutomationGridPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetItem*: proc(self: ptr IUIAutomationGridPattern, row: int32, column: int32, element: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CurrentRowCount*: proc(self: ptr IUIAutomationGridPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentColumnCount*: proc(self: ptr IUIAutomationGridPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedRowCount*: proc(self: ptr IUIAutomationGridPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedColumnCount*: proc(self: ptr IUIAutomationGridPattern, retVal: ptr int32): HRESULT {.stdcall.}
  IUIAutomationGridItemPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationGridItemPatternVtbl
  IUIAutomationGridItemPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_CurrentContainingGrid*: proc(self: ptr IUIAutomationGridItemPattern, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CurrentRow*: proc(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentColumn*: proc(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentRowSpan*: proc(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentColumnSpan*: proc(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedContainingGrid*: proc(self: ptr IUIAutomationGridItemPattern, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CachedRow*: proc(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedColumn*: proc(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedRowSpan*: proc(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedColumnSpan*: proc(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.stdcall.}
  IUIAutomationMultipleViewPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationMultipleViewPatternVtbl
  IUIAutomationMultipleViewPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetViewName*: proc(self: ptr IUIAutomationMultipleViewPattern, view: int32, name: ptr BSTR): HRESULT {.stdcall.}
    SetCurrentView*: proc(self: ptr IUIAutomationMultipleViewPattern, view: int32): HRESULT {.stdcall.}
    get_CurrentCurrentView*: proc(self: ptr IUIAutomationMultipleViewPattern, retVal: ptr int32): HRESULT {.stdcall.}
    GetCurrentSupportedViews*: proc(self: ptr IUIAutomationMultipleViewPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_CachedCurrentView*: proc(self: ptr IUIAutomationMultipleViewPattern, retVal: ptr int32): HRESULT {.stdcall.}
    GetCachedSupportedViews*: proc(self: ptr IUIAutomationMultipleViewPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  IUIAutomationObjectModelPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationObjectModelPatternVtbl
  IUIAutomationObjectModelPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetUnderlyingObjectModel*: proc(self: ptr IUIAutomationObjectModelPattern, retVal: ptr ptr IUnknown): HRESULT {.stdcall.}
  IUIAutomationRangeValuePattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationRangeValuePatternVtbl
  IUIAutomationRangeValuePatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetValue*: proc(self: ptr IUIAutomationRangeValuePattern, val: float64): HRESULT {.stdcall.}
    get_CurrentValue*: proc(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CurrentIsReadOnly*: proc(self: ptr IUIAutomationRangeValuePattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentMaximum*: proc(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CurrentMinimum*: proc(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CurrentLargeChange*: proc(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CurrentSmallChange*: proc(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CachedValue*: proc(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CachedIsReadOnly*: proc(self: ptr IUIAutomationRangeValuePattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedMaximum*: proc(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CachedMinimum*: proc(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CachedLargeChange*: proc(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CachedSmallChange*: proc(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.stdcall.}
  IUIAutomationScrollPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationScrollPatternVtbl
  IUIAutomationScrollPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Scroll*: proc(self: ptr IUIAutomationScrollPattern, horizontalAmount: ScrollAmount, verticalAmount: ScrollAmount): HRESULT {.stdcall.}
    SetScrollPercent*: proc(self: ptr IUIAutomationScrollPattern, horizontalPercent: float64, verticalPercent: float64): HRESULT {.stdcall.}
    get_CurrentHorizontalScrollPercent*: proc(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CurrentVerticalScrollPercent*: proc(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CurrentHorizontalViewSize*: proc(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CurrentVerticalViewSize*: proc(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CurrentHorizontallyScrollable*: proc(self: ptr IUIAutomationScrollPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentVerticallyScrollable*: proc(self: ptr IUIAutomationScrollPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedHorizontalScrollPercent*: proc(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CachedVerticalScrollPercent*: proc(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CachedHorizontalViewSize*: proc(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CachedVerticalViewSize*: proc(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.stdcall.}
    get_CachedHorizontallyScrollable*: proc(self: ptr IUIAutomationScrollPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedVerticallyScrollable*: proc(self: ptr IUIAutomationScrollPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
  IUIAutomationScrollItemPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationScrollItemPatternVtbl
  IUIAutomationScrollItemPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    ScrollIntoView*: proc(self: ptr IUIAutomationScrollItemPattern): HRESULT {.stdcall.}
  IUIAutomationSelectionPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationSelectionPatternVtbl
  IUIAutomationSelectionPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCurrentSelection*: proc(self: ptr IUIAutomationSelectionPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CurrentCanSelectMultiple*: proc(self: ptr IUIAutomationSelectionPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentIsSelectionRequired*: proc(self: ptr IUIAutomationSelectionPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    GetCachedSelection*: proc(self: ptr IUIAutomationSelectionPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CachedCanSelectMultiple*: proc(self: ptr IUIAutomationSelectionPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedIsSelectionRequired*: proc(self: ptr IUIAutomationSelectionPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
  IUIAutomationSelectionPattern2* {.pure.} = object
    lpVtbl*: ptr IUIAutomationSelectionPattern2Vtbl
  IUIAutomationSelectionPattern2Vtbl* {.pure, inheritable.} = object of IUIAutomationSelectionPatternVtbl
    get_CurrentFirstSelectedItem*: proc(self: ptr IUIAutomationSelectionPattern2, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CurrentLastSelectedItem*: proc(self: ptr IUIAutomationSelectionPattern2, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CurrentCurrentSelectedItem*: proc(self: ptr IUIAutomationSelectionPattern2, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CurrentItemCount*: proc(self: ptr IUIAutomationSelectionPattern2, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedFirstSelectedItem*: proc(self: ptr IUIAutomationSelectionPattern2, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CachedLastSelectedItem*: proc(self: ptr IUIAutomationSelectionPattern2, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CachedCurrentSelectedItem*: proc(self: ptr IUIAutomationSelectionPattern2, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CachedItemCount*: proc(self: ptr IUIAutomationSelectionPattern2, retVal: ptr int32): HRESULT {.stdcall.}
  IUIAutomationSelectionItemPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationSelectionItemPatternVtbl
  IUIAutomationSelectionItemPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Select*: proc(self: ptr IUIAutomationSelectionItemPattern): HRESULT {.stdcall.}
    AddToSelection*: proc(self: ptr IUIAutomationSelectionItemPattern): HRESULT {.stdcall.}
    RemoveFromSelection*: proc(self: ptr IUIAutomationSelectionItemPattern): HRESULT {.stdcall.}
    get_CurrentIsSelected*: proc(self: ptr IUIAutomationSelectionItemPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentSelectionContainer*: proc(self: ptr IUIAutomationSelectionItemPattern, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CachedIsSelected*: proc(self: ptr IUIAutomationSelectionItemPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedSelectionContainer*: proc(self: ptr IUIAutomationSelectionItemPattern, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
  IUIAutomationSynchronizedInputPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationSynchronizedInputPatternVtbl
  IUIAutomationSynchronizedInputPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    StartListening*: proc(self: ptr IUIAutomationSynchronizedInputPattern, inputType: SynchronizedInputType): HRESULT {.stdcall.}
    Cancel*: proc(self: ptr IUIAutomationSynchronizedInputPattern): HRESULT {.stdcall.}
  IUIAutomationTablePattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTablePatternVtbl
  IUIAutomationTablePatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCurrentRowHeaders*: proc(self: ptr IUIAutomationTablePattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    GetCurrentColumnHeaders*: proc(self: ptr IUIAutomationTablePattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CurrentRowOrColumnMajor*: proc(self: ptr IUIAutomationTablePattern, retVal: ptr RowOrColumnMajor): HRESULT {.stdcall.}
    GetCachedRowHeaders*: proc(self: ptr IUIAutomationTablePattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    GetCachedColumnHeaders*: proc(self: ptr IUIAutomationTablePattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CachedRowOrColumnMajor*: proc(self: ptr IUIAutomationTablePattern, retVal: ptr RowOrColumnMajor): HRESULT {.stdcall.}
  IUIAutomationTableItemPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTableItemPatternVtbl
  IUIAutomationTableItemPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetCurrentRowHeaderItems*: proc(self: ptr IUIAutomationTableItemPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    GetCurrentColumnHeaderItems*: proc(self: ptr IUIAutomationTableItemPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    GetCachedRowHeaderItems*: proc(self: ptr IUIAutomationTableItemPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    GetCachedColumnHeaderItems*: proc(self: ptr IUIAutomationTableItemPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
  IUIAutomationTogglePattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTogglePatternVtbl
  IUIAutomationTogglePatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Toggle*: proc(self: ptr IUIAutomationTogglePattern): HRESULT {.stdcall.}
    get_CurrentToggleState*: proc(self: ptr IUIAutomationTogglePattern, retVal: ptr ToggleState): HRESULT {.stdcall.}
    get_CachedToggleState*: proc(self: ptr IUIAutomationTogglePattern, retVal: ptr ToggleState): HRESULT {.stdcall.}
  IUIAutomationTransformPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTransformPatternVtbl
  IUIAutomationTransformPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Move*: proc(self: ptr IUIAutomationTransformPattern, x: float64, y: float64): HRESULT {.stdcall.}
    Resize*: proc(self: ptr IUIAutomationTransformPattern, width: float64, height: float64): HRESULT {.stdcall.}
    Rotate*: proc(self: ptr IUIAutomationTransformPattern, degrees: float64): HRESULT {.stdcall.}
    get_CurrentCanMove*: proc(self: ptr IUIAutomationTransformPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentCanResize*: proc(self: ptr IUIAutomationTransformPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentCanRotate*: proc(self: ptr IUIAutomationTransformPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedCanMove*: proc(self: ptr IUIAutomationTransformPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedCanResize*: proc(self: ptr IUIAutomationTransformPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedCanRotate*: proc(self: ptr IUIAutomationTransformPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
  IUIAutomationValuePattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationValuePatternVtbl
  IUIAutomationValuePatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    SetValue*: proc(self: ptr IUIAutomationValuePattern, val: BSTR): HRESULT {.stdcall.}
    get_CurrentValue*: proc(self: ptr IUIAutomationValuePattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentIsReadOnly*: proc(self: ptr IUIAutomationValuePattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedValue*: proc(self: ptr IUIAutomationValuePattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedIsReadOnly*: proc(self: ptr IUIAutomationValuePattern, retVal: ptr BOOL): HRESULT {.stdcall.}
  IUIAutomationWindowPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationWindowPatternVtbl
  IUIAutomationWindowPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Close*: proc(self: ptr IUIAutomationWindowPattern): HRESULT {.stdcall.}
    WaitForInputIdle*: proc(self: ptr IUIAutomationWindowPattern, milliseconds: int32, success: ptr BOOL): HRESULT {.stdcall.}
    SetWindowVisualState*: proc(self: ptr IUIAutomationWindowPattern, state: WindowVisualState): HRESULT {.stdcall.}
    get_CurrentCanMaximize*: proc(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentCanMinimize*: proc(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentIsModal*: proc(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentIsTopmost*: proc(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentWindowVisualState*: proc(self: ptr IUIAutomationWindowPattern, retVal: ptr WindowVisualState): HRESULT {.stdcall.}
    get_CurrentWindowInteractionState*: proc(self: ptr IUIAutomationWindowPattern, retVal: ptr WindowInteractionState): HRESULT {.stdcall.}
    get_CachedCanMaximize*: proc(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedCanMinimize*: proc(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedIsModal*: proc(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedIsTopmost*: proc(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedWindowVisualState*: proc(self: ptr IUIAutomationWindowPattern, retVal: ptr WindowVisualState): HRESULT {.stdcall.}
    get_CachedWindowInteractionState*: proc(self: ptr IUIAutomationWindowPattern, retVal: ptr WindowInteractionState): HRESULT {.stdcall.}
  IUIAutomationTextRange* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTextRangeVtbl
  IUIAutomationTextRangeVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Clone*: proc(self: ptr IUIAutomationTextRange, clonedRange: ptr ptr IUIAutomationTextRange): HRESULT {.stdcall.}
    Compare*: proc(self: ptr IUIAutomationTextRange, range: ptr IUIAutomationTextRange, areSame: ptr BOOL): HRESULT {.stdcall.}
    CompareEndpoints*: proc(self: ptr IUIAutomationTextRange, srcEndPoint: TextPatternRangeEndpoint, range: ptr IUIAutomationTextRange, targetEndPoint: TextPatternRangeEndpoint, compValue: ptr int32): HRESULT {.stdcall.}
    ExpandToEnclosingUnit*: proc(self: ptr IUIAutomationTextRange, textUnit: TextUnit): HRESULT {.stdcall.}
    FindAttribute*: proc(self: ptr IUIAutomationTextRange, attr: TEXTATTRIBUTEID, val: VARIANT, backward: BOOL, found: ptr ptr IUIAutomationTextRange): HRESULT {.stdcall.}
    FindText*: proc(self: ptr IUIAutomationTextRange, text: BSTR, backward: BOOL, ignoreCase: BOOL, found: ptr ptr IUIAutomationTextRange): HRESULT {.stdcall.}
    GetAttributeValue*: proc(self: ptr IUIAutomationTextRange, attr: TEXTATTRIBUTEID, value: ptr VARIANT): HRESULT {.stdcall.}
    GetBoundingRectangles*: proc(self: ptr IUIAutomationTextRange, boundingRects: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetEnclosingElement*: proc(self: ptr IUIAutomationTextRange, enclosingElement: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetText*: proc(self: ptr IUIAutomationTextRange, maxLength: int32, text: ptr BSTR): HRESULT {.stdcall.}
    Move*: proc(self: ptr IUIAutomationTextRange, unit: TextUnit, count: int32, moved: ptr int32): HRESULT {.stdcall.}
    MoveEndpointByUnit*: proc(self: ptr IUIAutomationTextRange, endpoint: TextPatternRangeEndpoint, unit: TextUnit, count: int32, moved: ptr int32): HRESULT {.stdcall.}
    MoveEndpointByRange*: proc(self: ptr IUIAutomationTextRange, srcEndPoint: TextPatternRangeEndpoint, range: ptr IUIAutomationTextRange, targetEndPoint: TextPatternRangeEndpoint): HRESULT {.stdcall.}
    Select*: proc(self: ptr IUIAutomationTextRange): HRESULT {.stdcall.}
    AddToSelection*: proc(self: ptr IUIAutomationTextRange): HRESULT {.stdcall.}
    RemoveFromSelection*: proc(self: ptr IUIAutomationTextRange): HRESULT {.stdcall.}
    ScrollIntoView*: proc(self: ptr IUIAutomationTextRange, alignToTop: BOOL): HRESULT {.stdcall.}
    GetChildren*: proc(self: ptr IUIAutomationTextRange, children: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
  IUIAutomationTextRange2* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTextRange2Vtbl
  IUIAutomationTextRange2Vtbl* {.pure, inheritable.} = object of IUIAutomationTextRangeVtbl
    ShowContextMenu*: proc(self: ptr IUIAutomationTextRange2): HRESULT {.stdcall.}
  IUIAutomationTextRange3* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTextRange3Vtbl
  IUIAutomationTextRange3Vtbl* {.pure, inheritable.} = object of IUIAutomationTextRange2Vtbl
    GetEnclosingElementBuildCache*: proc(self: ptr IUIAutomationTextRange3, cacheRequest: ptr IUIAutomationCacheRequest, enclosingElement: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetChildrenBuildCache*: proc(self: ptr IUIAutomationTextRange3, cacheRequest: ptr IUIAutomationCacheRequest, children: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    GetAttributeValues*: proc(self: ptr IUIAutomationTextRange3, attributeIds: ptr TEXTATTRIBUTEID, attributeIdCount: int32, attributeValues: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  IUIAutomationTextRangeArray* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTextRangeArrayVtbl
  IUIAutomationTextRangeArrayVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_Length*: proc(self: ptr IUIAutomationTextRangeArray, length: ptr int32): HRESULT {.stdcall.}
    GetElement*: proc(self: ptr IUIAutomationTextRangeArray, index: int32, element: ptr ptr IUIAutomationTextRange): HRESULT {.stdcall.}
  IUIAutomationTextPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTextPatternVtbl
  IUIAutomationTextPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    RangeFromPoint*: proc(self: ptr IUIAutomationTextPattern, pt: POINT, range: ptr ptr IUIAutomationTextRange): HRESULT {.stdcall.}
    RangeFromChild*: proc(self: ptr IUIAutomationTextPattern, child: ptr IUIAutomationElement, range: ptr ptr IUIAutomationTextRange): HRESULT {.stdcall.}
    GetSelection*: proc(self: ptr IUIAutomationTextPattern, ranges: ptr ptr IUIAutomationTextRangeArray): HRESULT {.stdcall.}
    GetVisibleRanges*: proc(self: ptr IUIAutomationTextPattern, ranges: ptr ptr IUIAutomationTextRangeArray): HRESULT {.stdcall.}
    get_DocumentRange*: proc(self: ptr IUIAutomationTextPattern, range: ptr ptr IUIAutomationTextRange): HRESULT {.stdcall.}
    get_SupportedTextSelection*: proc(self: ptr IUIAutomationTextPattern, supportedTextSelection: ptr SupportedTextSelection): HRESULT {.stdcall.}
  IUIAutomationTextPattern2* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTextPattern2Vtbl
  IUIAutomationTextPattern2Vtbl* {.pure, inheritable.} = object of IUIAutomationTextPatternVtbl
    RangeFromAnnotation*: proc(self: ptr IUIAutomationTextPattern2, annotation: ptr IUIAutomationElement, range: ptr ptr IUIAutomationTextRange): HRESULT {.stdcall.}
    GetCaretRange*: proc(self: ptr IUIAutomationTextPattern2, isActive: ptr BOOL, range: ptr ptr IUIAutomationTextRange): HRESULT {.stdcall.}
  IUIAutomationTextEditPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTextEditPatternVtbl
  IUIAutomationTextEditPatternVtbl* {.pure, inheritable.} = object of IUIAutomationTextPatternVtbl
    GetActiveComposition*: proc(self: ptr IUIAutomationTextEditPattern, range: ptr ptr IUIAutomationTextRange): HRESULT {.stdcall.}
    GetConversionTarget*: proc(self: ptr IUIAutomationTextEditPattern, range: ptr ptr IUIAutomationTextRange): HRESULT {.stdcall.}
  IUIAutomationCustomNavigationPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationCustomNavigationPatternVtbl
  IUIAutomationCustomNavigationPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Navigate*: proc(self: ptr IUIAutomationCustomNavigationPattern, direction: NavigateDirection, pRetVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
  IUIAutomationActiveTextPositionChangedEventHandler* {.pure.} = object
    lpVtbl*: ptr IUIAutomationActiveTextPositionChangedEventHandlerVtbl
  IUIAutomationActiveTextPositionChangedEventHandlerVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    HandleActiveTextPositionChangedEvent*: proc(self: ptr IUIAutomationActiveTextPositionChangedEventHandler, sender: ptr IUIAutomationElement, range: ptr IUIAutomationTextRange): HRESULT {.stdcall.}
  IUIAutomationLegacyIAccessiblePattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationLegacyIAccessiblePatternVtbl
  IUIAutomationLegacyIAccessiblePatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Select*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, flagsSelect: int32): HRESULT {.stdcall.}
    DoDefaultAction*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern): HRESULT {.stdcall.}
    SetValue*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, szValue: LPCWSTR): HRESULT {.stdcall.}
    get_CurrentChildId*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pRetVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentName*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pszName: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentValue*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pszValue: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentDescription*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pszDescription: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentRole*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pdwRole: ptr DWORD): HRESULT {.stdcall.}
    get_CurrentState*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pdwState: ptr DWORD): HRESULT {.stdcall.}
    get_CurrentHelp*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pszHelp: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentKeyboardShortcut*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pszKeyboardShortcut: ptr BSTR): HRESULT {.stdcall.}
    GetCurrentSelection*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pvarSelectedChildren: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CurrentDefaultAction*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pszDefaultAction: ptr BSTR): HRESULT {.stdcall.}
    get_CachedChildId*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pRetVal: ptr int32): HRESULT {.stdcall.}
    get_CachedName*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pszName: ptr BSTR): HRESULT {.stdcall.}
    get_CachedValue*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pszValue: ptr BSTR): HRESULT {.stdcall.}
    get_CachedDescription*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pszDescription: ptr BSTR): HRESULT {.stdcall.}
    get_CachedRole*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pdwRole: ptr DWORD): HRESULT {.stdcall.}
    get_CachedState*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pdwState: ptr DWORD): HRESULT {.stdcall.}
    get_CachedHelp*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pszHelp: ptr BSTR): HRESULT {.stdcall.}
    get_CachedKeyboardShortcut*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pszKeyboardShortcut: ptr BSTR): HRESULT {.stdcall.}
    GetCachedSelection*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pvarSelectedChildren: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CachedDefaultAction*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, pszDefaultAction: ptr BSTR): HRESULT {.stdcall.}
    GetIAccessible*: proc(self: ptr IUIAutomationLegacyIAccessiblePattern, ppAccessible: ptr ptr IAccessible): HRESULT {.stdcall.}
  IUIAutomationItemContainerPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationItemContainerPatternVtbl
  IUIAutomationItemContainerPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    FindItemByProperty*: proc(self: ptr IUIAutomationItemContainerPattern, pStartAfter: ptr IUIAutomationElement, propertyId: PROPERTYID, value: VARIANT, pFound: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
  IUIAutomationVirtualizedItemPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationVirtualizedItemPatternVtbl
  IUIAutomationVirtualizedItemPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Realize*: proc(self: ptr IUIAutomationVirtualizedItemPattern): HRESULT {.stdcall.}
  IUIAutomationAnnotationPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationAnnotationPatternVtbl
  IUIAutomationAnnotationPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_CurrentAnnotationTypeId*: proc(self: ptr IUIAutomationAnnotationPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentAnnotationTypeName*: proc(self: ptr IUIAutomationAnnotationPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentAuthor*: proc(self: ptr IUIAutomationAnnotationPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentDateTime*: proc(self: ptr IUIAutomationAnnotationPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentTarget*: proc(self: ptr IUIAutomationAnnotationPattern, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_CachedAnnotationTypeId*: proc(self: ptr IUIAutomationAnnotationPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedAnnotationTypeName*: proc(self: ptr IUIAutomationAnnotationPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedAuthor*: proc(self: ptr IUIAutomationAnnotationPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedDateTime*: proc(self: ptr IUIAutomationAnnotationPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedTarget*: proc(self: ptr IUIAutomationAnnotationPattern, retVal: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
  IUIAutomationStylesPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationStylesPatternVtbl
  IUIAutomationStylesPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_CurrentStyleId*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentStyleName*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentFillColor*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentFillPatternStyle*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentShape*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentFillPatternColor*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentExtendedProperties*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    GetCurrentExtendedPropertiesAsArray*: proc(self: ptr IUIAutomationStylesPattern, propertyArray: ptr ptr TExtendedProperty, propertyCount: ptr int32): HRESULT {.stdcall.}
    get_CachedStyleId*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedStyleName*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedFillColor*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedFillPatternStyle*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedShape*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedFillPatternColor*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedExtendedProperties*: proc(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    GetCachedExtendedPropertiesAsArray*: proc(self: ptr IUIAutomationStylesPattern, propertyArray: ptr ptr TExtendedProperty, propertyCount: ptr int32): HRESULT {.stdcall.}
  IUIAutomationSpreadsheetPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationSpreadsheetPatternVtbl
  IUIAutomationSpreadsheetPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetItemByName*: proc(self: ptr IUIAutomationSpreadsheetPattern, name: BSTR, element: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
  IUIAutomationSpreadsheetItemPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationSpreadsheetItemPatternVtbl
  IUIAutomationSpreadsheetItemPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_CurrentFormula*: proc(self: ptr IUIAutomationSpreadsheetItemPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    GetCurrentAnnotationObjects*: proc(self: ptr IUIAutomationSpreadsheetItemPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    GetCurrentAnnotationTypes*: proc(self: ptr IUIAutomationSpreadsheetItemPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_CachedFormula*: proc(self: ptr IUIAutomationSpreadsheetItemPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    GetCachedAnnotationObjects*: proc(self: ptr IUIAutomationSpreadsheetItemPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    GetCachedAnnotationTypes*: proc(self: ptr IUIAutomationSpreadsheetItemPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  IUIAutomationTransformPattern2* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTransformPattern2Vtbl
  IUIAutomationTransformPattern2Vtbl* {.pure, inheritable.} = object of IUIAutomationTransformPatternVtbl
    Zoom*: proc(self: ptr IUIAutomationTransformPattern2, zoomValue: float64): HRESULT {.stdcall.}
    ZoomByUnit*: proc(self: ptr IUIAutomationTransformPattern2, zoomUnit: ZoomUnit): HRESULT {.stdcall.}
    get_CurrentCanZoom*: proc(self: ptr IUIAutomationTransformPattern2, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedCanZoom*: proc(self: ptr IUIAutomationTransformPattern2, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentZoomLevel*: proc(self: ptr IUIAutomationTransformPattern2, retVal: ptr float64): HRESULT {.stdcall.}
    get_CachedZoomLevel*: proc(self: ptr IUIAutomationTransformPattern2, retVal: ptr float64): HRESULT {.stdcall.}
    get_CurrentZoomMinimum*: proc(self: ptr IUIAutomationTransformPattern2, retVal: ptr float64): HRESULT {.stdcall.}
    get_CachedZoomMinimum*: proc(self: ptr IUIAutomationTransformPattern2, retVal: ptr float64): HRESULT {.stdcall.}
    get_CurrentZoomMaximum*: proc(self: ptr IUIAutomationTransformPattern2, retVal: ptr float64): HRESULT {.stdcall.}
    get_CachedZoomMaximum*: proc(self: ptr IUIAutomationTransformPattern2, retVal: ptr float64): HRESULT {.stdcall.}
  IUIAutomationTextChildPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationTextChildPatternVtbl
  IUIAutomationTextChildPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_TextContainer*: proc(self: ptr IUIAutomationTextChildPattern, container: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    get_TextRange*: proc(self: ptr IUIAutomationTextChildPattern, range: ptr ptr IUIAutomationTextRange): HRESULT {.stdcall.}
  IUIAutomationDragPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationDragPatternVtbl
  IUIAutomationDragPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_CurrentIsGrabbed*: proc(self: ptr IUIAutomationDragPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedIsGrabbed*: proc(self: ptr IUIAutomationDragPattern, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentDropEffect*: proc(self: ptr IUIAutomationDragPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedDropEffect*: proc(self: ptr IUIAutomationDragPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentDropEffects*: proc(self: ptr IUIAutomationDragPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_CachedDropEffects*: proc(self: ptr IUIAutomationDragPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetCurrentGrabbedItems*: proc(self: ptr IUIAutomationDragPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    GetCachedGrabbedItems*: proc(self: ptr IUIAutomationDragPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
  IUIAutomationDropTargetPattern* {.pure.} = object
    lpVtbl*: ptr IUIAutomationDropTargetPatternVtbl
  IUIAutomationDropTargetPatternVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_CurrentDropTargetEffect*: proc(self: ptr IUIAutomationDropTargetPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedDropTargetEffect*: proc(self: ptr IUIAutomationDropTargetPattern, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CurrentDropTargetEffects*: proc(self: ptr IUIAutomationDropTargetPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_CachedDropTargetEffects*: proc(self: ptr IUIAutomationDropTargetPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  IUIAutomationElement2* {.pure.} = object
    lpVtbl*: ptr IUIAutomationElement2Vtbl
  IUIAutomationElement2Vtbl* {.pure, inheritable.} = object of IUIAutomationElementVtbl
    get_CurrentOptimizeForVisualContent*: proc(self: ptr IUIAutomationElement2, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedOptimizeForVisualContent*: proc(self: ptr IUIAutomationElement2, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CurrentLiveSetting*: proc(self: ptr IUIAutomationElement2, retVal: ptr LiveSetting): HRESULT {.stdcall.}
    get_CachedLiveSetting*: proc(self: ptr IUIAutomationElement2, retVal: ptr LiveSetting): HRESULT {.stdcall.}
    get_CurrentFlowsFrom*: proc(self: ptr IUIAutomationElement2, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CachedFlowsFrom*: proc(self: ptr IUIAutomationElement2, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
  IUIAutomationElement3* {.pure.} = object
    lpVtbl*: ptr IUIAutomationElement3Vtbl
  IUIAutomationElement3Vtbl* {.pure, inheritable.} = object of IUIAutomationElement2Vtbl
    ShowContextMenu*: proc(self: ptr IUIAutomationElement3): HRESULT {.stdcall.}
    get_CurrentIsPeripheral*: proc(self: ptr IUIAutomationElement3, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedIsPeripheral*: proc(self: ptr IUIAutomationElement3, retVal: ptr BOOL): HRESULT {.stdcall.}
  IUIAutomationElement4* {.pure.} = object
    lpVtbl*: ptr IUIAutomationElement4Vtbl
  IUIAutomationElement4Vtbl* {.pure, inheritable.} = object of IUIAutomationElement3Vtbl
    get_CurrentPositionInSet*: proc(self: ptr IUIAutomationElement4, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentSizeOfSet*: proc(self: ptr IUIAutomationElement4, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentLevel*: proc(self: ptr IUIAutomationElement4, retVal: ptr int32): HRESULT {.stdcall.}
    get_CurrentAnnotationTypes*: proc(self: ptr IUIAutomationElement4, retVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_CurrentAnnotationObjects*: proc(self: ptr IUIAutomationElement4, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    get_CachedPositionInSet*: proc(self: ptr IUIAutomationElement4, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedSizeOfSet*: proc(self: ptr IUIAutomationElement4, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedLevel*: proc(self: ptr IUIAutomationElement4, retVal: ptr int32): HRESULT {.stdcall.}
    get_CachedAnnotationTypes*: proc(self: ptr IUIAutomationElement4, retVal: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    get_CachedAnnotationObjects*: proc(self: ptr IUIAutomationElement4, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
  IUIAutomationElement5* {.pure.} = object
    lpVtbl*: ptr IUIAutomationElement5Vtbl
  IUIAutomationElement5Vtbl* {.pure, inheritable.} = object of IUIAutomationElement4Vtbl
    get_CurrentLandmarkType*: proc(self: ptr IUIAutomationElement5, retVal: ptr LANDMARKTYPEID): HRESULT {.stdcall.}
    get_CurrentLocalizedLandmarkType*: proc(self: ptr IUIAutomationElement5, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedLandmarkType*: proc(self: ptr IUIAutomationElement5, retVal: ptr LANDMARKTYPEID): HRESULT {.stdcall.}
    get_CachedLocalizedLandmarkType*: proc(self: ptr IUIAutomationElement5, retVal: ptr BSTR): HRESULT {.stdcall.}
  IUIAutomationElement6* {.pure.} = object
    lpVtbl*: ptr IUIAutomationElement6Vtbl
  IUIAutomationElement6Vtbl* {.pure, inheritable.} = object of IUIAutomationElement5Vtbl
    get_CurrentFullDescription*: proc(self: ptr IUIAutomationElement6, retVal: ptr BSTR): HRESULT {.stdcall.}
    get_CachedFullDescription*: proc(self: ptr IUIAutomationElement6, retVal: ptr BSTR): HRESULT {.stdcall.}
  IUIAutomationElement7* {.pure.} = object
    lpVtbl*: ptr IUIAutomationElement7Vtbl
  IUIAutomationElement7Vtbl* {.pure, inheritable.} = object of IUIAutomationElement6Vtbl
    FindFirstWithOptions*: proc(self: ptr IUIAutomationElement7, scope: TreeScope, condition: ptr IUIAutomationCondition, traversalOptions: TreeTraversalOptions, root: ptr IUIAutomationElement, found: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    FindAllWithOptions*: proc(self: ptr IUIAutomationElement7, scope: TreeScope, condition: ptr IUIAutomationCondition, traversalOptions: TreeTraversalOptions, root: ptr IUIAutomationElement, found: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    FindFirstWithOptionsBuildCache*: proc(self: ptr IUIAutomationElement7, scope: TreeScope, condition: ptr IUIAutomationCondition, cacheRequest: ptr IUIAutomationCacheRequest, traversalOptions: TreeTraversalOptions, root: ptr IUIAutomationElement, found: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    FindAllWithOptionsBuildCache*: proc(self: ptr IUIAutomationElement7, scope: TreeScope, condition: ptr IUIAutomationCondition, cacheRequest: ptr IUIAutomationCacheRequest, traversalOptions: TreeTraversalOptions, root: ptr IUIAutomationElement, found: ptr ptr IUIAutomationElementArray): HRESULT {.stdcall.}
    GetCurrentMetadataValue*: proc(self: ptr IUIAutomationElement7, targetId: int32, metadataId: METADATAID, returnVal: ptr VARIANT): HRESULT {.stdcall.}
  IUIAutomationElement8* {.pure.} = object
    lpVtbl*: ptr IUIAutomationElement8Vtbl
  IUIAutomationElement8Vtbl* {.pure, inheritable.} = object of IUIAutomationElement7Vtbl
    get_CurrentHeadingLevel*: proc(self: ptr IUIAutomationElement8, retVal: ptr HEADINGLEVELID): HRESULT {.stdcall.}
    get_CachedHeadingLevel*: proc(self: ptr IUIAutomationElement8, retVal: ptr HEADINGLEVELID): HRESULT {.stdcall.}
  IUIAutomationElement9* {.pure.} = object
    lpVtbl*: ptr IUIAutomationElement9Vtbl
  IUIAutomationElement9Vtbl* {.pure, inheritable.} = object of IUIAutomationElement8Vtbl
    get_CurrentIsDialog*: proc(self: ptr IUIAutomationElement9, retVal: ptr BOOL): HRESULT {.stdcall.}
    get_CachedIsDialog*: proc(self: ptr IUIAutomationElement9, retVal: ptr BOOL): HRESULT {.stdcall.}
  IUIAutomationProxyFactory* {.pure.} = object
    lpVtbl*: ptr IUIAutomationProxyFactoryVtbl
  IUIAutomationProxyFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateProvider*: proc(self: ptr IUIAutomationProxyFactory, hwnd: UIA_HWND, idObject: LONG, idChild: LONG, provider: ptr ptr IRawElementProviderSimple): HRESULT {.stdcall.}
    get_ProxyFactoryId*: proc(self: ptr IUIAutomationProxyFactory, factoryId: ptr BSTR): HRESULT {.stdcall.}
  IUIAutomationProxyFactoryEntry* {.pure.} = object
    lpVtbl*: ptr IUIAutomationProxyFactoryEntryVtbl
  IUIAutomationProxyFactoryEntryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_ProxyFactory*: proc(self: ptr IUIAutomationProxyFactoryEntry, factory: ptr ptr IUIAutomationProxyFactory): HRESULT {.stdcall.}
    get_ClassName*: proc(self: ptr IUIAutomationProxyFactoryEntry, className: ptr BSTR): HRESULT {.stdcall.}
    get_ImageName*: proc(self: ptr IUIAutomationProxyFactoryEntry, imageName: ptr BSTR): HRESULT {.stdcall.}
    get_AllowSubstringMatch*: proc(self: ptr IUIAutomationProxyFactoryEntry, allowSubstringMatch: ptr BOOL): HRESULT {.stdcall.}
    get_CanCheckBaseClass*: proc(self: ptr IUIAutomationProxyFactoryEntry, canCheckBaseClass: ptr BOOL): HRESULT {.stdcall.}
    get_NeedsAdviseEvents*: proc(self: ptr IUIAutomationProxyFactoryEntry, adviseEvents: ptr BOOL): HRESULT {.stdcall.}
    put_ClassName*: proc(self: ptr IUIAutomationProxyFactoryEntry, className: LPCWSTR): HRESULT {.stdcall.}
    put_ImageName*: proc(self: ptr IUIAutomationProxyFactoryEntry, imageName: LPCWSTR): HRESULT {.stdcall.}
    put_AllowSubstringMatch*: proc(self: ptr IUIAutomationProxyFactoryEntry, allowSubstringMatch: BOOL): HRESULT {.stdcall.}
    put_CanCheckBaseClass*: proc(self: ptr IUIAutomationProxyFactoryEntry, canCheckBaseClass: BOOL): HRESULT {.stdcall.}
    put_NeedsAdviseEvents*: proc(self: ptr IUIAutomationProxyFactoryEntry, adviseEvents: BOOL): HRESULT {.stdcall.}
    SetWinEventsForAutomationEvent*: proc(self: ptr IUIAutomationProxyFactoryEntry, eventId: EVENTID, propertyId: PROPERTYID, winEvents: ptr SAFEARRAY): HRESULT {.stdcall.}
    GetWinEventsForAutomationEvent*: proc(self: ptr IUIAutomationProxyFactoryEntry, eventId: EVENTID, propertyId: PROPERTYID, winEvents: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
  IUIAutomationProxyFactoryMapping* {.pure.} = object
    lpVtbl*: ptr IUIAutomationProxyFactoryMappingVtbl
  IUIAutomationProxyFactoryMappingVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    get_Count*: proc(self: ptr IUIAutomationProxyFactoryMapping, count: ptr UINT): HRESULT {.stdcall.}
    GetTable*: proc(self: ptr IUIAutomationProxyFactoryMapping, table: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    GetEntry*: proc(self: ptr IUIAutomationProxyFactoryMapping, index: UINT, entry: ptr ptr IUIAutomationProxyFactoryEntry): HRESULT {.stdcall.}
    SetTable*: proc(self: ptr IUIAutomationProxyFactoryMapping, factoryList: ptr SAFEARRAY): HRESULT {.stdcall.}
    InsertEntries*: proc(self: ptr IUIAutomationProxyFactoryMapping, before: UINT, factoryList: ptr SAFEARRAY): HRESULT {.stdcall.}
    InsertEntry*: proc(self: ptr IUIAutomationProxyFactoryMapping, before: UINT, factory: ptr IUIAutomationProxyFactoryEntry): HRESULT {.stdcall.}
    RemoveEntry*: proc(self: ptr IUIAutomationProxyFactoryMapping, index: UINT): HRESULT {.stdcall.}
    ClearTable*: proc(self: ptr IUIAutomationProxyFactoryMapping): HRESULT {.stdcall.}
    RestoreDefaultTable*: proc(self: ptr IUIAutomationProxyFactoryMapping): HRESULT {.stdcall.}
  IUIAutomationEventHandlerGroup* {.pure.} = object
    lpVtbl*: ptr IUIAutomationEventHandlerGroupVtbl
  IUIAutomationEventHandlerGroupVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    AddActiveTextPositionChangedEventHandler*: proc(self: ptr IUIAutomationEventHandlerGroup, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationActiveTextPositionChangedEventHandler): HRESULT {.stdcall.}
    AddAutomationEventHandler*: proc(self: ptr IUIAutomationEventHandlerGroup, eventId: EVENTID, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationEventHandler): HRESULT {.stdcall.}
    AddChangesEventHandler*: proc(self: ptr IUIAutomationEventHandlerGroup, scope: TreeScope, changeTypes: ptr int32, changesCount: int32, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationChangesEventHandler): HRESULT {.stdcall.}
    AddNotificationEventHandler*: proc(self: ptr IUIAutomationEventHandlerGroup, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationNotificationEventHandler): HRESULT {.stdcall.}
    AddPropertyChangedEventHandler*: proc(self: ptr IUIAutomationEventHandlerGroup, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationPropertyChangedEventHandler, propertyArray: ptr PROPERTYID, propertyCount: int32): HRESULT {.stdcall.}
    AddStructureChangedEventHandler*: proc(self: ptr IUIAutomationEventHandlerGroup, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationStructureChangedEventHandler): HRESULT {.stdcall.}
    AddTextEditTextChangedEventHandler*: proc(self: ptr IUIAutomationEventHandlerGroup, scope: TreeScope, textEditChangeType: TextEditChangeType, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationTextEditTextChangedEventHandler): HRESULT {.stdcall.}
  IUIAutomation* {.pure.} = object
    lpVtbl*: ptr IUIAutomationVtbl
  IUIAutomationVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CompareElements*: proc(self: ptr IUIAutomation, el1: ptr IUIAutomationElement, el2: ptr IUIAutomationElement, areSame: ptr BOOL): HRESULT {.stdcall.}
    CompareRuntimeIds*: proc(self: ptr IUIAutomation, runtimeId1: ptr SAFEARRAY, runtimeId2: ptr SAFEARRAY, areSame: ptr BOOL): HRESULT {.stdcall.}
    GetRootElement*: proc(self: ptr IUIAutomation, root: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    ElementFromHandle*: proc(self: ptr IUIAutomation, hwnd: UIA_HWND, element: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    ElementFromPoint*: proc(self: ptr IUIAutomation, pt: POINT, element: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetFocusedElement*: proc(self: ptr IUIAutomation, element: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetRootElementBuildCache*: proc(self: ptr IUIAutomation, cacheRequest: ptr IUIAutomationCacheRequest, root: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    ElementFromHandleBuildCache*: proc(self: ptr IUIAutomation, hwnd: UIA_HWND, cacheRequest: ptr IUIAutomationCacheRequest, element: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    ElementFromPointBuildCache*: proc(self: ptr IUIAutomation, pt: POINT, cacheRequest: ptr IUIAutomationCacheRequest, element: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    GetFocusedElementBuildCache*: proc(self: ptr IUIAutomation, cacheRequest: ptr IUIAutomationCacheRequest, element: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    CreateTreeWalker*: proc(self: ptr IUIAutomation, pCondition: ptr IUIAutomationCondition, walker: ptr ptr IUIAutomationTreeWalker): HRESULT {.stdcall.}
    get_ControlViewWalker*: proc(self: ptr IUIAutomation, walker: ptr ptr IUIAutomationTreeWalker): HRESULT {.stdcall.}
    get_ContentViewWalker*: proc(self: ptr IUIAutomation, walker: ptr ptr IUIAutomationTreeWalker): HRESULT {.stdcall.}
    get_RawViewWalker*: proc(self: ptr IUIAutomation, walker: ptr ptr IUIAutomationTreeWalker): HRESULT {.stdcall.}
    get_RawViewCondition*: proc(self: ptr IUIAutomation, condition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    get_ControlViewCondition*: proc(self: ptr IUIAutomation, condition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    get_ContentViewCondition*: proc(self: ptr IUIAutomation, condition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    CreateCacheRequest*: proc(self: ptr IUIAutomation, cacheRequest: ptr ptr IUIAutomationCacheRequest): HRESULT {.stdcall.}
    CreateTrueCondition*: proc(self: ptr IUIAutomation, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    CreateFalseCondition*: proc(self: ptr IUIAutomation, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    CreatePropertyCondition*: proc(self: ptr IUIAutomation, propertyId: PROPERTYID, value: VARIANT, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    CreatePropertyConditionEx*: proc(self: ptr IUIAutomation, propertyId: PROPERTYID, value: VARIANT, flags: PropertyConditionFlags, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    CreateAndCondition*: proc(self: ptr IUIAutomation, condition1: ptr IUIAutomationCondition, condition2: ptr IUIAutomationCondition, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    CreateAndConditionFromArray*: proc(self: ptr IUIAutomation, conditions: ptr SAFEARRAY, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    CreateAndConditionFromNativeArray*: proc(self: ptr IUIAutomation, conditions: ptr ptr IUIAutomationCondition, conditionCount: int32, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    CreateOrCondition*: proc(self: ptr IUIAutomation, condition1: ptr IUIAutomationCondition, condition2: ptr IUIAutomationCondition, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    CreateOrConditionFromArray*: proc(self: ptr IUIAutomation, conditions: ptr SAFEARRAY, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    CreateOrConditionFromNativeArray*: proc(self: ptr IUIAutomation, conditions: ptr ptr IUIAutomationCondition, conditionCount: int32, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    CreateNotCondition*: proc(self: ptr IUIAutomation, condition: ptr IUIAutomationCondition, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.stdcall.}
    AddAutomationEventHandler*: proc(self: ptr IUIAutomation, eventId: EVENTID, element: ptr IUIAutomationElement, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationEventHandler): HRESULT {.stdcall.}
    RemoveAutomationEventHandler*: proc(self: ptr IUIAutomation, eventId: EVENTID, element: ptr IUIAutomationElement, handler: ptr IUIAutomationEventHandler): HRESULT {.stdcall.}
    AddPropertyChangedEventHandlerNativeArray*: proc(self: ptr IUIAutomation, element: ptr IUIAutomationElement, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationPropertyChangedEventHandler, propertyArray: ptr PROPERTYID, propertyCount: int32): HRESULT {.stdcall.}
    AddPropertyChangedEventHandler*: proc(self: ptr IUIAutomation, element: ptr IUIAutomationElement, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationPropertyChangedEventHandler, propertyArray: ptr SAFEARRAY): HRESULT {.stdcall.}
    RemovePropertyChangedEventHandler*: proc(self: ptr IUIAutomation, element: ptr IUIAutomationElement, handler: ptr IUIAutomationPropertyChangedEventHandler): HRESULT {.stdcall.}
    AddStructureChangedEventHandler*: proc(self: ptr IUIAutomation, element: ptr IUIAutomationElement, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationStructureChangedEventHandler): HRESULT {.stdcall.}
    RemoveStructureChangedEventHandler*: proc(self: ptr IUIAutomation, element: ptr IUIAutomationElement, handler: ptr IUIAutomationStructureChangedEventHandler): HRESULT {.stdcall.}
    AddFocusChangedEventHandler*: proc(self: ptr IUIAutomation, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationFocusChangedEventHandler): HRESULT {.stdcall.}
    RemoveFocusChangedEventHandler*: proc(self: ptr IUIAutomation, handler: ptr IUIAutomationFocusChangedEventHandler): HRESULT {.stdcall.}
    RemoveAllEventHandlers*: proc(self: ptr IUIAutomation): HRESULT {.stdcall.}
    IntNativeArrayToSafeArray*: proc(self: ptr IUIAutomation, array: ptr int32, arrayCount: int32, safeArray: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    IntSafeArrayToNativeArray*: proc(self: ptr IUIAutomation, intArray: ptr SAFEARRAY, array: ptr ptr int32, arrayCount: ptr int32): HRESULT {.stdcall.}
    RectToVariant*: proc(self: ptr IUIAutomation, rc: RECT, `var`: ptr VARIANT): HRESULT {.stdcall.}
    VariantToRect*: proc(self: ptr IUIAutomation, `var`: VARIANT, rc: ptr RECT): HRESULT {.stdcall.}
    SafeArrayToRectNativeArray*: proc(self: ptr IUIAutomation, rects: ptr SAFEARRAY, rectArray: ptr ptr RECT, rectArrayCount: ptr int32): HRESULT {.stdcall.}
    CreateProxyFactoryEntry*: proc(self: ptr IUIAutomation, factory: ptr IUIAutomationProxyFactory, factoryEntry: ptr ptr IUIAutomationProxyFactoryEntry): HRESULT {.stdcall.}
    get_ProxyFactoryMapping*: proc(self: ptr IUIAutomation, factoryMapping: ptr ptr IUIAutomationProxyFactoryMapping): HRESULT {.stdcall.}
    GetPropertyProgrammaticName*: proc(self: ptr IUIAutomation, property: PROPERTYID, name: ptr BSTR): HRESULT {.stdcall.}
    GetPatternProgrammaticName*: proc(self: ptr IUIAutomation, pattern: PATTERNID, name: ptr BSTR): HRESULT {.stdcall.}
    PollForPotentialSupportedPatterns*: proc(self: ptr IUIAutomation, pElement: ptr IUIAutomationElement, patternIds: ptr ptr SAFEARRAY, patternNames: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    PollForPotentialSupportedProperties*: proc(self: ptr IUIAutomation, pElement: ptr IUIAutomationElement, propertyIds: ptr ptr SAFEARRAY, propertyNames: ptr ptr SAFEARRAY): HRESULT {.stdcall.}
    CheckNotSupported*: proc(self: ptr IUIAutomation, value: VARIANT, isNotSupported: ptr BOOL): HRESULT {.stdcall.}
    get_ReservedNotSupportedValue*: proc(self: ptr IUIAutomation, notSupportedValue: ptr ptr IUnknown): HRESULT {.stdcall.}
    get_ReservedMixedAttributeValue*: proc(self: ptr IUIAutomation, mixedAttributeValue: ptr ptr IUnknown): HRESULT {.stdcall.}
    ElementFromIAccessible*: proc(self: ptr IUIAutomation, accessible: ptr IAccessible, childId: int32, element: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
    ElementFromIAccessibleBuildCache*: proc(self: ptr IUIAutomation, accessible: ptr IAccessible, childId: int32, cacheRequest: ptr IUIAutomationCacheRequest, element: ptr ptr IUIAutomationElement): HRESULT {.stdcall.}
  IUIAutomation2* {.pure.} = object
    lpVtbl*: ptr IUIAutomation2Vtbl
  IUIAutomation2Vtbl* {.pure, inheritable.} = object of IUIAutomationVtbl
    get_AutoSetFocus*: proc(self: ptr IUIAutomation2, autoSetFocus: ptr BOOL): HRESULT {.stdcall.}
    put_AutoSetFocus*: proc(self: ptr IUIAutomation2, autoSetFocus: BOOL): HRESULT {.stdcall.}
    get_ConnectionTimeout*: proc(self: ptr IUIAutomation2, timeout: ptr DWORD): HRESULT {.stdcall.}
    put_ConnectionTimeout*: proc(self: ptr IUIAutomation2, timeout: DWORD): HRESULT {.stdcall.}
    get_TransactionTimeout*: proc(self: ptr IUIAutomation2, timeout: ptr DWORD): HRESULT {.stdcall.}
    put_TransactionTimeout*: proc(self: ptr IUIAutomation2, timeout: DWORD): HRESULT {.stdcall.}
  IUIAutomation3* {.pure.} = object
    lpVtbl*: ptr IUIAutomation3Vtbl
  IUIAutomation3Vtbl* {.pure, inheritable.} = object of IUIAutomation2Vtbl
    AddTextEditTextChangedEventHandler*: proc(self: ptr IUIAutomation3, element: ptr IUIAutomationElement, scope: TreeScope, textEditChangeType: TextEditChangeType, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationTextEditTextChangedEventHandler): HRESULT {.stdcall.}
    RemoveTextEditTextChangedEventHandler*: proc(self: ptr IUIAutomation3, element: ptr IUIAutomationElement, handler: ptr IUIAutomationTextEditTextChangedEventHandler): HRESULT {.stdcall.}
  IUIAutomation4* {.pure.} = object
    lpVtbl*: ptr IUIAutomation4Vtbl
  IUIAutomation4Vtbl* {.pure, inheritable.} = object of IUIAutomation3Vtbl
    AddChangesEventHandler*: proc(self: ptr IUIAutomation4, element: ptr IUIAutomationElement, scope: TreeScope, changeTypes: ptr int32, changesCount: int32, pCacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationChangesEventHandler): HRESULT {.stdcall.}
    RemoveChangesEventHandler*: proc(self: ptr IUIAutomation4, element: ptr IUIAutomationElement, handler: ptr IUIAutomationChangesEventHandler): HRESULT {.stdcall.}
  IUIAutomation5* {.pure.} = object
    lpVtbl*: ptr IUIAutomation5Vtbl
  IUIAutomation5Vtbl* {.pure, inheritable.} = object of IUIAutomation4Vtbl
    AddNotificationEventHandler*: proc(self: ptr IUIAutomation5, element: ptr IUIAutomationElement, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationNotificationEventHandler): HRESULT {.stdcall.}
    RemoveNotificationEventHandler*: proc(self: ptr IUIAutomation5, element: ptr IUIAutomationElement, handler: ptr IUIAutomationNotificationEventHandler): HRESULT {.stdcall.}
  IUIAutomation6* {.pure.} = object
    lpVtbl*: ptr IUIAutomation6Vtbl
  IUIAutomation6Vtbl* {.pure, inheritable.} = object of IUIAutomation5Vtbl
    CreateEventHandlerGroup*: proc(self: ptr IUIAutomation6, handlerGroup: ptr ptr IUIAutomationEventHandlerGroup): HRESULT {.stdcall.}
    AddEventHandlerGroup*: proc(self: ptr IUIAutomation6, element: ptr IUIAutomationElement, handlerGroup: ptr IUIAutomationEventHandlerGroup): HRESULT {.stdcall.}
    RemoveEventHandlerGroup*: proc(self: ptr IUIAutomation6, element: ptr IUIAutomationElement, handlerGroup: ptr IUIAutomationEventHandlerGroup): HRESULT {.stdcall.}
    get_ConnectionRecoveryBehavior*: proc(self: ptr IUIAutomation6, connectionRecoveryBehaviorOptions: ptr ConnectionRecoveryBehaviorOptions): HRESULT {.stdcall.}
    put_ConnectionRecoveryBehavior*: proc(self: ptr IUIAutomation6, connectionRecoveryBehaviorOptions: ConnectionRecoveryBehaviorOptions): HRESULT {.stdcall.}
    get_CoalesceEvents*: proc(self: ptr IUIAutomation6, coalesceEventsOptions: ptr CoalesceEventsOptions): HRESULT {.stdcall.}
    put_CoalesceEvents*: proc(self: ptr IUIAutomation6, coalesceEventsOptions: CoalesceEventsOptions): HRESULT {.stdcall.}
    AddActiveTextPositionChangedEventHandler*: proc(self: ptr IUIAutomation6, element: ptr IUIAutomationElement, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationActiveTextPositionChangedEventHandler): HRESULT {.stdcall.}
    RemoveActiveTextPositionChangedEventHandler*: proc(self: ptr IUIAutomation6, element: ptr IUIAutomationElement, handler: ptr IUIAutomationActiveTextPositionChangedEventHandler): HRESULT {.stdcall.}
proc UiaGetErrorDescription*(pDescription: ptr BSTR): BOOL {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaHUiaNodeFromVariant*(pvar: ptr VARIANT, phnode: ptr HUIANODE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaHPatternObjectFromVariant*(pvar: ptr VARIANT, phobj: ptr HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaHTextRangeFromVariant*(pvar: ptr VARIANT, phtextrange: ptr HUIATEXTRANGE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaNodeRelease*(hnode: HUIANODE): BOOL {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaGetPropertyValue*(hnode: HUIANODE, propertyId: PROPERTYID, pValue: ptr VARIANT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaGetPatternProvider*(hnode: HUIANODE, patternId: PATTERNID, phobj: ptr HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaGetRuntimeId*(hnode: HUIANODE, pruntimeId: ptr ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaSetFocus*(hnode: HUIANODE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaNavigate*(hnode: HUIANODE, direction: NavigateDirection, pCondition: ptr UiaCondition, pRequest: ptr UiaCacheRequest, ppRequestedData: ptr ptr SAFEARRAY, ppTreeStructure: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaGetUpdatedCache*(hnode: HUIANODE, pRequest: ptr UiaCacheRequest, normalizeState: NormalizeState, pNormalizeCondition: ptr UiaCondition, ppRequestedData: ptr ptr SAFEARRAY, ppTreeStructure: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaFind*(hnode: HUIANODE, pParams: ptr UiaFindParams, pRequest: ptr UiaCacheRequest, ppRequestedData: ptr ptr SAFEARRAY, ppOffsets: ptr ptr SAFEARRAY, ppTreeStructures: ptr ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaNodeFromPoint*(x: float64, y: float64, pRequest: ptr UiaCacheRequest, ppRequestedData: ptr ptr SAFEARRAY, ppTreeStructure: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaNodeFromFocus*(pRequest: ptr UiaCacheRequest, ppRequestedData: ptr ptr SAFEARRAY, ppTreeStructure: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaNodeFromHandle*(hwnd: HWND, phnode: ptr HUIANODE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaNodeFromProvider*(pProvider: ptr IRawElementProviderSimple, phnode: ptr HUIANODE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaGetRootNode*(phnode: ptr HUIANODE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaRegisterProviderCallback*(pCallback: UiaProviderCallback): void {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaLookupId*(`type`: AutomationIdentifierType, pGuid: ptr GUID): int32 {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaGetReservedNotSupportedValue*(punkNotSupportedValue: ptr ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaGetReservedMixedAttributeValue*(punkMixedAttributeValue: ptr ptr IUnknown): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaClientsAreListening*(): BOOL {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaRaiseAutomationPropertyChangedEvent*(pProvider: ptr IRawElementProviderSimple, id: PROPERTYID, oldValue: VARIANT, newValue: VARIANT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaRaiseAutomationEvent*(pProvider: ptr IRawElementProviderSimple, id: EVENTID): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaRaiseStructureChangedEvent*(pProvider: ptr IRawElementProviderSimple, structureChangeType: StructureChangeType, pRuntimeId: ptr int32, cRuntimeIdLen: int32): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaRaiseAsyncContentLoadedEvent*(pProvider: ptr IRawElementProviderSimple, asyncContentLoadedState: AsyncContentLoadedState, percentComplete: float64): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaRaiseTextEditTextChangedEvent*(pProvider: ptr IRawElementProviderSimple, textEditChangeType: TextEditChangeType, pChangedData: ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaRaiseChangesEvent*(pProvider: ptr IRawElementProviderSimple, eventIdCount: int32, pUiaChanges: ptr UiaChangeInfo): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaRaiseNotificationEvent*(provider: ptr IRawElementProviderSimple, notificationKind: NotificationKind, notificationProcessing: NotificationProcessing, displayString: BSTR, activityId: BSTR): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaRaiseActiveTextPositionChangedEvent*(provider: ptr IRawElementProviderSimple, textRange: ptr ITextRangeProvider): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaAddEvent*(hnode: HUIANODE, eventId: EVENTID, pCallback: UiaEventCallback, scope: TreeScope, pProperties: ptr PROPERTYID, cProperties: int32, pRequest: ptr UiaCacheRequest, phEvent: ptr HUIAEVENT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaRemoveEvent*(hEvent: HUIAEVENT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaEventAddWindow*(hEvent: HUIAEVENT, hwnd: HWND): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaEventRemoveWindow*(hEvent: HUIAEVENT, hwnd: HWND): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc DockPattern_SetDockPosition*(hobj: HUIAPATTERNOBJECT, dockPosition: DockPosition): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc ExpandCollapsePattern_Collapse*(hobj: HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc ExpandCollapsePattern_Expand*(hobj: HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc GridPattern_GetItem*(hobj: HUIAPATTERNOBJECT, row: int32, column: int32, pResult: ptr HUIANODE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc InvokePattern_Invoke*(hobj: HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc MultipleViewPattern_GetViewName*(hobj: HUIAPATTERNOBJECT, viewId: int32, ppStr: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc MultipleViewPattern_SetCurrentView*(hobj: HUIAPATTERNOBJECT, viewId: int32): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc RangeValuePattern_SetValue*(hobj: HUIAPATTERNOBJECT, val: float64): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc ScrollItemPattern_ScrollIntoView*(hobj: HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc ScrollPattern_Scroll*(hobj: HUIAPATTERNOBJECT, horizontalAmount: ScrollAmount, verticalAmount: ScrollAmount): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc ScrollPattern_SetScrollPercent*(hobj: HUIAPATTERNOBJECT, horizontalPercent: float64, verticalPercent: float64): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc SelectionItemPattern_AddToSelection*(hobj: HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc SelectionItemPattern_RemoveFromSelection*(hobj: HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc SelectionItemPattern_Select*(hobj: HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TogglePattern_Toggle*(hobj: HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TransformPattern_Move*(hobj: HUIAPATTERNOBJECT, x: float64, y: float64): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TransformPattern_Resize*(hobj: HUIAPATTERNOBJECT, width: float64, height: float64): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TransformPattern_Rotate*(hobj: HUIAPATTERNOBJECT, degrees: float64): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc ValuePattern_SetValue*(hobj: HUIAPATTERNOBJECT, pVal: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc WindowPattern_Close*(hobj: HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc WindowPattern_SetWindowVisualState*(hobj: HUIAPATTERNOBJECT, state: WindowVisualState): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc WindowPattern_WaitForInputIdle*(hobj: HUIAPATTERNOBJECT, milliseconds: int32, pResult: ptr BOOL): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextPattern_GetSelection*(hobj: HUIAPATTERNOBJECT, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextPattern_GetVisibleRanges*(hobj: HUIAPATTERNOBJECT, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextPattern_RangeFromChild*(hobj: HUIAPATTERNOBJECT, hnodeChild: HUIANODE, pRetVal: ptr HUIATEXTRANGE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextPattern_RangeFromPoint*(hobj: HUIAPATTERNOBJECT, point: UiaPoint, pRetVal: ptr HUIATEXTRANGE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextPattern_get_DocumentRange*(hobj: HUIAPATTERNOBJECT, pRetVal: ptr HUIATEXTRANGE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextPattern_get_SupportedTextSelection*(hobj: HUIAPATTERNOBJECT, pRetVal: ptr SupportedTextSelection): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_Clone*(hobj: HUIATEXTRANGE, pRetVal: ptr HUIATEXTRANGE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_Compare*(hobj: HUIATEXTRANGE, range: HUIATEXTRANGE, pRetVal: ptr BOOL): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_CompareEndpoints*(hobj: HUIATEXTRANGE, endpoint: TextPatternRangeEndpoint, targetRange: HUIATEXTRANGE, targetEndpoint: TextPatternRangeEndpoint, pRetVal: ptr int32): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_ExpandToEnclosingUnit*(hobj: HUIATEXTRANGE, unit: TextUnit): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_GetAttributeValue*(hobj: HUIATEXTRANGE, attributeId: TEXTATTRIBUTEID, pRetVal: ptr VARIANT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_FindAttribute*(hobj: HUIATEXTRANGE, attributeId: TEXTATTRIBUTEID, val: VARIANT, backward: BOOL, pRetVal: ptr HUIATEXTRANGE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_FindText*(hobj: HUIATEXTRANGE, text: BSTR, backward: BOOL, ignoreCase: BOOL, pRetVal: ptr HUIATEXTRANGE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_GetBoundingRectangles*(hobj: HUIATEXTRANGE, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_GetEnclosingElement*(hobj: HUIATEXTRANGE, pRetVal: ptr HUIANODE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_GetText*(hobj: HUIATEXTRANGE, maxLength: int32, pRetVal: ptr BSTR): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_Move*(hobj: HUIATEXTRANGE, unit: TextUnit, count: int32, pRetVal: ptr int32): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_MoveEndpointByUnit*(hobj: HUIATEXTRANGE, endpoint: TextPatternRangeEndpoint, unit: TextUnit, count: int32, pRetVal: ptr int32): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_MoveEndpointByRange*(hobj: HUIATEXTRANGE, endpoint: TextPatternRangeEndpoint, targetRange: HUIATEXTRANGE, targetEndpoint: TextPatternRangeEndpoint): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_Select*(hobj: HUIATEXTRANGE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_AddToSelection*(hobj: HUIATEXTRANGE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_RemoveFromSelection*(hobj: HUIATEXTRANGE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_ScrollIntoView*(hobj: HUIATEXTRANGE, alignToTop: BOOL): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc TextRange_GetChildren*(hobj: HUIATEXTRANGE, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc ItemContainerPattern_FindItemByProperty*(hobj: HUIAPATTERNOBJECT, hnodeStartAfter: HUIANODE, propertyId: PROPERTYID, value: VARIANT, pFound: ptr HUIANODE): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc LegacyIAccessiblePattern_Select*(hobj: HUIAPATTERNOBJECT, flagsSelect: int32): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc LegacyIAccessiblePattern_DoDefaultAction*(hobj: HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc LegacyIAccessiblePattern_SetValue*(hobj: HUIAPATTERNOBJECT, szValue: LPCWSTR): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc LegacyIAccessiblePattern_GetIAccessible*(hobj: HUIAPATTERNOBJECT, pAccessible: ptr ptr IAccessible): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc SynchronizedInputPattern_StartListening*(hobj: HUIAPATTERNOBJECT, inputType: SynchronizedInputType): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc SynchronizedInputPattern_Cancel*(hobj: HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc VirtualizedItemPattern_Realize*(hobj: HUIAPATTERNOBJECT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaPatternRelease*(hobj: HUIAPATTERNOBJECT): BOOL {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaTextRangeRelease*(hobj: HUIATEXTRANGE): BOOL {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaReturnRawElementProvider*(hwnd: HWND, wParam: WPARAM, lParam: LPARAM, el: ptr IRawElementProviderSimple): LRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaHostProviderFromHwnd*(hwnd: HWND, ppProvider: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaProviderForNonClient*(hwnd: HWND, idObject: int32, idChild: int32, ppProvider: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaIAccessibleFromProvider*(pProvider: ptr IRawElementProviderSimple, dwFlags: DWORD, ppAccessible: ptr ptr IAccessible, pvarChild: ptr VARIANT): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaProviderFromIAccessible*(pAccessible: ptr IAccessible, idChild: int32, dwFlags: DWORD, ppProvider: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaDisconnectAllProviders*(): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaDisconnectProvider*(pProvider: ptr IRawElementProviderSimple): HRESULT {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc UiaHasServerSideProvider*(hwnd: HWND): BOOL {.winapi, stdcall, dynlib: "uiautomationcore", importc.}
proc get_ProviderOptions*(self: ptr IRawElementProviderSimple, pRetVal: ptr ProviderOptions): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ProviderOptions(self, pRetVal)
proc GetPatternProvider*(self: ptr IRawElementProviderSimple, patternId: PATTERNID, pRetVal: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPatternProvider(self, patternId, pRetVal)
proc GetPropertyValue*(self: ptr IRawElementProviderSimple, propertyId: PROPERTYID, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyValue(self, propertyId, pRetVal)
proc get_HostRawElementProvider*(self: ptr IRawElementProviderSimple, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_HostRawElementProvider(self, pRetVal)
proc GetObjectForChild*(self: ptr IAccessibleEx, idChild: int32, pRetVal: ptr ptr IAccessibleEx): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObjectForChild(self, idChild, pRetVal)
proc GetIAccessiblePair*(self: ptr IAccessibleEx, ppAcc: ptr ptr IAccessible, pidChild: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIAccessiblePair(self, ppAcc, pidChild)
proc GetRuntimeId*(self: ptr IAccessibleEx, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRuntimeId(self, pRetVal)
proc ConvertReturnedElement*(self: ptr IAccessibleEx, pIn: ptr IRawElementProviderSimple, ppRetValOut: ptr ptr IAccessibleEx): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ConvertReturnedElement(self, pIn, ppRetValOut)
proc ShowContextMenu*(self: ptr IRawElementProviderSimple2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowContextMenu(self)
proc GetMetadataValue*(self: ptr IRawElementProviderSimple3, targetId: int32, metadataId: METADATAID, returnVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMetadataValue(self, targetId, metadataId, returnVal)
proc ElementProviderFromPoint*(self: ptr IRawElementProviderFragmentRoot, x: float64, y: float64, pRetVal: ptr ptr IRawElementProviderFragment): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ElementProviderFromPoint(self, x, y, pRetVal)
proc GetFocus*(self: ptr IRawElementProviderFragmentRoot, pRetVal: ptr ptr IRawElementProviderFragment): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFocus(self, pRetVal)
proc Navigate*(self: ptr IRawElementProviderFragment, direction: NavigateDirection, pRetVal: ptr ptr IRawElementProviderFragment): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Navigate(self, direction, pRetVal)
proc GetRuntimeId*(self: ptr IRawElementProviderFragment, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRuntimeId(self, pRetVal)
proc get_BoundingRectangle*(self: ptr IRawElementProviderFragment, pRetVal: ptr UiaRect): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_BoundingRectangle(self, pRetVal)
proc GetEmbeddedFragmentRoots*(self: ptr IRawElementProviderFragment, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEmbeddedFragmentRoots(self, pRetVal)
proc SetFocus*(self: ptr IRawElementProviderFragment): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFocus(self)
proc get_FragmentRoot*(self: ptr IRawElementProviderFragment, pRetVal: ptr ptr IRawElementProviderFragmentRoot): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_FragmentRoot(self, pRetVal)
proc AdviseEventAdded*(self: ptr IRawElementProviderAdviseEvents, eventId: EVENTID, propertyIDs: ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AdviseEventAdded(self, eventId, propertyIDs)
proc AdviseEventRemoved*(self: ptr IRawElementProviderAdviseEvents, eventId: EVENTID, propertyIDs: ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AdviseEventRemoved(self, eventId, propertyIDs)
proc GetOverrideProviderForHwnd*(self: ptr IRawElementProviderHwndOverride, hwnd: HWND, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetOverrideProviderForHwnd(self, hwnd, pRetVal)
proc AddAutomationPropertyChangedEvent*(self: ptr IProxyProviderWinEventSink, pProvider: ptr IRawElementProviderSimple, id: PROPERTYID, newValue: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddAutomationPropertyChangedEvent(self, pProvider, id, newValue)
proc AddAutomationEvent*(self: ptr IProxyProviderWinEventSink, pProvider: ptr IRawElementProviderSimple, id: EVENTID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddAutomationEvent(self, pProvider, id)
proc AddStructureChangedEvent*(self: ptr IProxyProviderWinEventSink, pProvider: ptr IRawElementProviderSimple, structureChangeType: StructureChangeType, runtimeId: ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddStructureChangedEvent(self, pProvider, structureChangeType, runtimeId)
proc RespondToWinEvent*(self: ptr IProxyProviderWinEventHandler, idWinEvent: DWORD, hwnd: HWND, idObject: LONG, idChild: LONG, pSink: ptr IProxyProviderWinEventSink): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RespondToWinEvent(self, idWinEvent, hwnd, idObject, idChild, pSink)
proc GetAdjacentFragment*(self: ptr IRawElementProviderWindowlessSite, direction: NavigateDirection, ppParent: ptr ptr IRawElementProviderFragment): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAdjacentFragment(self, direction, ppParent)
proc GetRuntimeIdPrefix*(self: ptr IRawElementProviderWindowlessSite, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRuntimeIdPrefix(self, pRetVal)
proc GetEmbeddedFragmentRoots*(self: ptr IAccessibleHostingElementProviders, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEmbeddedFragmentRoots(self, pRetVal)
proc GetObjectIdForProvider*(self: ptr IAccessibleHostingElementProviders, pProvider: ptr IRawElementProviderSimple, pidObject: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObjectIdForProvider(self, pProvider, pidObject)
proc GetEmbeddedAccessibles*(self: ptr IRawElementProviderHostingAccessibles, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEmbeddedAccessibles(self, pRetVal)
proc SetDockPosition*(self: ptr IDockProvider, dockPosition: DockPosition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDockPosition(self, dockPosition)
proc get_DockPosition*(self: ptr IDockProvider, pRetVal: ptr DockPosition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_DockPosition(self, pRetVal)
proc Expand*(self: ptr IExpandCollapseProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Expand(self)
proc Collapse*(self: ptr IExpandCollapseProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Collapse(self)
proc get_ExpandCollapseState*(self: ptr IExpandCollapseProvider, pRetVal: ptr ExpandCollapseState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ExpandCollapseState(self, pRetVal)
proc GetItem*(self: ptr IGridProvider, row: int32, column: int32, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItem(self, row, column, pRetVal)
proc get_RowCount*(self: ptr IGridProvider, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_RowCount(self, pRetVal)
proc get_ColumnCount*(self: ptr IGridProvider, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ColumnCount(self, pRetVal)
proc get_Row*(self: ptr IGridItemProvider, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Row(self, pRetVal)
proc get_Column*(self: ptr IGridItemProvider, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Column(self, pRetVal)
proc get_RowSpan*(self: ptr IGridItemProvider, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_RowSpan(self, pRetVal)
proc get_ColumnSpan*(self: ptr IGridItemProvider, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ColumnSpan(self, pRetVal)
proc get_ContainingGrid*(self: ptr IGridItemProvider, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ContainingGrid(self, pRetVal)
proc Invoke*(self: ptr IInvokeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Invoke(self)
proc GetViewName*(self: ptr IMultipleViewProvider, viewId: int32, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetViewName(self, viewId, pRetVal)
proc SetCurrentView*(self: ptr IMultipleViewProvider, viewId: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCurrentView(self, viewId)
proc get_CurrentView*(self: ptr IMultipleViewProvider, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentView(self, pRetVal)
proc GetSupportedViews*(self: ptr IMultipleViewProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSupportedViews(self, pRetVal)
proc SetValue*(self: ptr IRangeValueProvider, val: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetValue(self, val)
proc get_Value*(self: ptr IRangeValueProvider, pRetVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Value(self, pRetVal)
proc get_IsReadOnly*(self: ptr IRangeValueProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsReadOnly(self, pRetVal)
proc get_Maximum*(self: ptr IRangeValueProvider, pRetVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Maximum(self, pRetVal)
proc get_Minimum*(self: ptr IRangeValueProvider, pRetVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Minimum(self, pRetVal)
proc get_LargeChange*(self: ptr IRangeValueProvider, pRetVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_LargeChange(self, pRetVal)
proc get_SmallChange*(self: ptr IRangeValueProvider, pRetVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_SmallChange(self, pRetVal)
proc ScrollIntoView*(self: ptr IScrollItemProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ScrollIntoView(self)
proc GetSelection*(self: ptr ISelectionProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelection(self, pRetVal)
proc get_CanSelectMultiple*(self: ptr ISelectionProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CanSelectMultiple(self, pRetVal)
proc get_IsSelectionRequired*(self: ptr ISelectionProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsSelectionRequired(self, pRetVal)
proc get_FirstSelectedItem*(self: ptr ISelectionProvider2, retVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_FirstSelectedItem(self, retVal)
proc get_LastSelectedItem*(self: ptr ISelectionProvider2, retVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_LastSelectedItem(self, retVal)
proc get_CurrentSelectedItem*(self: ptr ISelectionProvider2, retVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentSelectedItem(self, retVal)
proc get_ItemCount*(self: ptr ISelectionProvider2, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ItemCount(self, retVal)
proc Scroll*(self: ptr IScrollProvider, horizontalAmount: ScrollAmount, verticalAmount: ScrollAmount): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Scroll(self, horizontalAmount, verticalAmount)
proc SetScrollPercent*(self: ptr IScrollProvider, horizontalPercent: float64, verticalPercent: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetScrollPercent(self, horizontalPercent, verticalPercent)
proc get_HorizontalScrollPercent*(self: ptr IScrollProvider, pRetVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_HorizontalScrollPercent(self, pRetVal)
proc get_VerticalScrollPercent*(self: ptr IScrollProvider, pRetVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_VerticalScrollPercent(self, pRetVal)
proc get_HorizontalViewSize*(self: ptr IScrollProvider, pRetVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_HorizontalViewSize(self, pRetVal)
proc get_VerticalViewSize*(self: ptr IScrollProvider, pRetVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_VerticalViewSize(self, pRetVal)
proc get_HorizontallyScrollable*(self: ptr IScrollProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_HorizontallyScrollable(self, pRetVal)
proc get_VerticallyScrollable*(self: ptr IScrollProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_VerticallyScrollable(self, pRetVal)
proc Select*(self: ptr ISelectionItemProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Select(self)
proc AddToSelection*(self: ptr ISelectionItemProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddToSelection(self)
proc RemoveFromSelection*(self: ptr ISelectionItemProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveFromSelection(self)
proc get_IsSelected*(self: ptr ISelectionItemProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsSelected(self, pRetVal)
proc get_SelectionContainer*(self: ptr ISelectionItemProvider, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_SelectionContainer(self, pRetVal)
proc StartListening*(self: ptr ISynchronizedInputProvider, inputType: SynchronizedInputType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StartListening(self, inputType)
proc Cancel*(self: ptr ISynchronizedInputProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Cancel(self)
proc GetRowHeaders*(self: ptr ITableProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRowHeaders(self, pRetVal)
proc GetColumnHeaders*(self: ptr ITableProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColumnHeaders(self, pRetVal)
proc get_RowOrColumnMajor*(self: ptr ITableProvider, pRetVal: ptr RowOrColumnMajor): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_RowOrColumnMajor(self, pRetVal)
proc GetRowHeaderItems*(self: ptr ITableItemProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRowHeaderItems(self, pRetVal)
proc GetColumnHeaderItems*(self: ptr ITableItemProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColumnHeaderItems(self, pRetVal)
proc Toggle*(self: ptr IToggleProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Toggle(self)
proc get_ToggleState*(self: ptr IToggleProvider, pRetVal: ptr ToggleState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ToggleState(self, pRetVal)
proc Move*(self: ptr ITransformProvider, x: float64, y: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Move(self, x, y)
proc Resize*(self: ptr ITransformProvider, width: float64, height: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Resize(self, width, height)
proc Rotate*(self: ptr ITransformProvider, degrees: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Rotate(self, degrees)
proc get_CanMove*(self: ptr ITransformProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CanMove(self, pRetVal)
proc get_CanResize*(self: ptr ITransformProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CanResize(self, pRetVal)
proc get_CanRotate*(self: ptr ITransformProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CanRotate(self, pRetVal)
proc SetValue*(self: ptr IValueProvider, val: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetValue(self, val)
proc get_Value*(self: ptr IValueProvider, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Value(self, pRetVal)
proc get_IsReadOnly*(self: ptr IValueProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsReadOnly(self, pRetVal)
proc SetVisualState*(self: ptr IWindowProvider, state: WindowVisualState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetVisualState(self, state)
proc Close*(self: ptr IWindowProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Close(self)
proc WaitForInputIdle*(self: ptr IWindowProvider, milliseconds: int32, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WaitForInputIdle(self, milliseconds, pRetVal)
proc get_CanMaximize*(self: ptr IWindowProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CanMaximize(self, pRetVal)
proc get_CanMinimize*(self: ptr IWindowProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CanMinimize(self, pRetVal)
proc get_IsModal*(self: ptr IWindowProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsModal(self, pRetVal)
proc get_WindowVisualState*(self: ptr IWindowProvider, pRetVal: ptr WindowVisualState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_WindowVisualState(self, pRetVal)
proc get_WindowInteractionState*(self: ptr IWindowProvider, pRetVal: ptr WindowInteractionState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_WindowInteractionState(self, pRetVal)
proc get_IsTopmost*(self: ptr IWindowProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsTopmost(self, pRetVal)
proc Select*(self: ptr ILegacyIAccessibleProvider, flagsSelect: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Select(self, flagsSelect)
proc DoDefaultAction*(self: ptr ILegacyIAccessibleProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoDefaultAction(self)
proc SetValue*(self: ptr ILegacyIAccessibleProvider, szValue: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetValue(self, szValue)
proc GetIAccessible*(self: ptr ILegacyIAccessibleProvider, ppAccessible: ptr ptr IAccessible): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIAccessible(self, ppAccessible)
proc get_ChildId*(self: ptr ILegacyIAccessibleProvider, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ChildId(self, pRetVal)
proc get_Name*(self: ptr ILegacyIAccessibleProvider, pszName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Name(self, pszName)
proc get_Value*(self: ptr ILegacyIAccessibleProvider, pszValue: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Value(self, pszValue)
proc get_Description*(self: ptr ILegacyIAccessibleProvider, pszDescription: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Description(self, pszDescription)
proc get_Role*(self: ptr ILegacyIAccessibleProvider, pdwRole: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Role(self, pdwRole)
proc get_State*(self: ptr ILegacyIAccessibleProvider, pdwState: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_State(self, pdwState)
proc get_Help*(self: ptr ILegacyIAccessibleProvider, pszHelp: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Help(self, pszHelp)
proc get_KeyboardShortcut*(self: ptr ILegacyIAccessibleProvider, pszKeyboardShortcut: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_KeyboardShortcut(self, pszKeyboardShortcut)
proc GetSelection*(self: ptr ILegacyIAccessibleProvider, pvarSelectedChildren: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelection(self, pvarSelectedChildren)
proc get_DefaultAction*(self: ptr ILegacyIAccessibleProvider, pszDefaultAction: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_DefaultAction(self, pszDefaultAction)
proc FindItemByProperty*(self: ptr IItemContainerProvider, pStartAfter: ptr IRawElementProviderSimple, propertyId: PROPERTYID, value: VARIANT, pFound: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindItemByProperty(self, pStartAfter, propertyId, value, pFound)
proc Realize*(self: ptr IVirtualizedItemProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Realize(self)
proc GetUnderlyingObjectModel*(self: ptr IObjectModelProvider, ppUnknown: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUnderlyingObjectModel(self, ppUnknown)
proc get_AnnotationTypeId*(self: ptr IAnnotationProvider, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_AnnotationTypeId(self, retVal)
proc get_AnnotationTypeName*(self: ptr IAnnotationProvider, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_AnnotationTypeName(self, retVal)
proc get_Author*(self: ptr IAnnotationProvider, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Author(self, retVal)
proc get_DateTime*(self: ptr IAnnotationProvider, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_DateTime(self, retVal)
proc get_Target*(self: ptr IAnnotationProvider, retVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Target(self, retVal)
proc get_StyleId*(self: ptr IStylesProvider, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_StyleId(self, retVal)
proc get_StyleName*(self: ptr IStylesProvider, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_StyleName(self, retVal)
proc get_FillColor*(self: ptr IStylesProvider, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_FillColor(self, retVal)
proc get_FillPatternStyle*(self: ptr IStylesProvider, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_FillPatternStyle(self, retVal)
proc get_Shape*(self: ptr IStylesProvider, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Shape(self, retVal)
proc get_FillPatternColor*(self: ptr IStylesProvider, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_FillPatternColor(self, retVal)
proc get_ExtendedProperties*(self: ptr IStylesProvider, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ExtendedProperties(self, retVal)
proc GetItemByName*(self: ptr ISpreadsheetProvider, name: LPCWSTR, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemByName(self, name, pRetVal)
proc get_Formula*(self: ptr ISpreadsheetItemProvider, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Formula(self, pRetVal)
proc GetAnnotationObjects*(self: ptr ISpreadsheetItemProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAnnotationObjects(self, pRetVal)
proc GetAnnotationTypes*(self: ptr ISpreadsheetItemProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAnnotationTypes(self, pRetVal)
proc Zoom*(self: ptr ITransformProvider2, zoom: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Zoom(self, zoom)
proc get_CanZoom*(self: ptr ITransformProvider2, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CanZoom(self, pRetVal)
proc get_ZoomLevel*(self: ptr ITransformProvider2, pRetVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ZoomLevel(self, pRetVal)
proc get_ZoomMinimum*(self: ptr ITransformProvider2, pRetVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ZoomMinimum(self, pRetVal)
proc get_ZoomMaximum*(self: ptr ITransformProvider2, pRetVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ZoomMaximum(self, pRetVal)
proc ZoomByUnit*(self: ptr ITransformProvider2, zoomUnit: ZoomUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ZoomByUnit(self, zoomUnit)
proc get_IsGrabbed*(self: ptr IDragProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_IsGrabbed(self, pRetVal)
proc get_DropEffect*(self: ptr IDragProvider, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_DropEffect(self, pRetVal)
proc get_DropEffects*(self: ptr IDragProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_DropEffects(self, pRetVal)
proc GetGrabbedItems*(self: ptr IDragProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetGrabbedItems(self, pRetVal)
proc get_DropTargetEffect*(self: ptr IDropTargetProvider, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_DropTargetEffect(self, pRetVal)
proc get_DropTargetEffects*(self: ptr IDropTargetProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_DropTargetEffects(self, pRetVal)
proc Clone*(self: ptr ITextRangeProvider, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, pRetVal)
proc Compare*(self: ptr ITextRangeProvider, range: ptr ITextRangeProvider, pRetVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Compare(self, range, pRetVal)
proc CompareEndpoints*(self: ptr ITextRangeProvider, endpoint: TextPatternRangeEndpoint, targetRange: ptr ITextRangeProvider, targetEndpoint: TextPatternRangeEndpoint, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CompareEndpoints(self, endpoint, targetRange, targetEndpoint, pRetVal)
proc ExpandToEnclosingUnit*(self: ptr ITextRangeProvider, unit: TextUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExpandToEnclosingUnit(self, unit)
proc FindAttribute*(self: ptr ITextRangeProvider, attributeId: TEXTATTRIBUTEID, val: VARIANT, backward: BOOL, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindAttribute(self, attributeId, val, backward, pRetVal)
proc FindText*(self: ptr ITextRangeProvider, text: BSTR, backward: BOOL, ignoreCase: BOOL, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindText(self, text, backward, ignoreCase, pRetVal)
proc GetAttributeValue*(self: ptr ITextRangeProvider, attributeId: TEXTATTRIBUTEID, pRetVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAttributeValue(self, attributeId, pRetVal)
proc GetBoundingRectangles*(self: ptr ITextRangeProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBoundingRectangles(self, pRetVal)
proc GetEnclosingElement*(self: ptr ITextRangeProvider, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEnclosingElement(self, pRetVal)
proc GetText*(self: ptr ITextRangeProvider, maxLength: int32, pRetVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetText(self, maxLength, pRetVal)
proc Move*(self: ptr ITextRangeProvider, unit: TextUnit, count: int32, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Move(self, unit, count, pRetVal)
proc MoveEndpointByUnit*(self: ptr ITextRangeProvider, endpoint: TextPatternRangeEndpoint, unit: TextUnit, count: int32, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveEndpointByUnit(self, endpoint, unit, count, pRetVal)
proc MoveEndpointByRange*(self: ptr ITextRangeProvider, endpoint: TextPatternRangeEndpoint, targetRange: ptr ITextRangeProvider, targetEndpoint: TextPatternRangeEndpoint): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveEndpointByRange(self, endpoint, targetRange, targetEndpoint)
proc Select*(self: ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Select(self)
proc AddToSelection*(self: ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddToSelection(self)
proc RemoveFromSelection*(self: ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveFromSelection(self)
proc ScrollIntoView*(self: ptr ITextRangeProvider, alignToTop: BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ScrollIntoView(self, alignToTop)
proc GetChildren*(self: ptr ITextRangeProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetChildren(self, pRetVal)
proc GetSelection*(self: ptr ITextProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelection(self, pRetVal)
proc GetVisibleRanges*(self: ptr ITextProvider, pRetVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetVisibleRanges(self, pRetVal)
proc RangeFromChild*(self: ptr ITextProvider, childElement: ptr IRawElementProviderSimple, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RangeFromChild(self, childElement, pRetVal)
proc RangeFromPoint*(self: ptr ITextProvider, point: UiaPoint, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RangeFromPoint(self, point, pRetVal)
proc get_DocumentRange*(self: ptr ITextProvider, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_DocumentRange(self, pRetVal)
proc get_SupportedTextSelection*(self: ptr ITextProvider, pRetVal: ptr SupportedTextSelection): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_SupportedTextSelection(self, pRetVal)
proc RangeFromAnnotation*(self: ptr ITextProvider2, annotationElement: ptr IRawElementProviderSimple, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RangeFromAnnotation(self, annotationElement, pRetVal)
proc GetCaretRange*(self: ptr ITextProvider2, isActive: ptr BOOL, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCaretRange(self, isActive, pRetVal)
proc GetActiveComposition*(self: ptr ITextEditProvider, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetActiveComposition(self, pRetVal)
proc GetConversionTarget*(self: ptr ITextEditProvider, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConversionTarget(self, pRetVal)
proc ShowContextMenu*(self: ptr ITextRangeProvider2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowContextMenu(self)
proc get_TextContainer*(self: ptr ITextChildProvider, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_TextContainer(self, pRetVal)
proc get_TextRange*(self: ptr ITextChildProvider, pRetVal: ptr ptr ITextRangeProvider): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_TextRange(self, pRetVal)
proc Navigate*(self: ptr ICustomNavigationProvider, direction: NavigateDirection, pRetVal: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Navigate(self, direction, pRetVal)
proc GetProperty*(self: ptr IUIAutomationPatternInstance, index: UINT, cached: BOOL, `type`: UIAutomationType, pPtr: pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProperty(self, index, cached, `type`, pPtr)
proc CallMethod*(self: ptr IUIAutomationPatternInstance, index: UINT, pParams: ptr UIAutomationParameter, cParams: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CallMethod(self, index, pParams, cParams)
proc CreateClientWrapper*(self: ptr IUIAutomationPatternHandler, pPatternInstance: ptr IUIAutomationPatternInstance, pClientWrapper: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateClientWrapper(self, pPatternInstance, pClientWrapper)
proc Dispatch*(self: ptr IUIAutomationPatternHandler, pTarget: ptr IUnknown, index: UINT, pParams: ptr UIAutomationParameter, cParams: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Dispatch(self, pTarget, index, pParams, cParams)
proc RegisterProperty*(self: ptr IUIAutomationRegistrar, property: ptr UIAutomationPropertyInfo, propertyId: ptr PROPERTYID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterProperty(self, property, propertyId)
proc RegisterEvent*(self: ptr IUIAutomationRegistrar, event: ptr UIAutomationEventInfo, eventId: ptr EVENTID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterEvent(self, event, eventId)
proc RegisterPattern*(self: ptr IUIAutomationRegistrar, pattern: ptr UIAutomationPatternInfo, pPatternId: ptr PATTERNID, pPatternAvailablePropertyId: ptr PROPERTYID, propertyIdCount: UINT, pPropertyIds: ptr PROPERTYID, eventIdCount: UINT, pEventIds: ptr EVENTID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RegisterPattern(self, pattern, pPatternId, pPatternAvailablePropertyId, propertyIdCount, pPropertyIds, eventIdCount, pEventIds)
proc SetFocus*(self: ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetFocus(self)
proc GetRuntimeId*(self: ptr IUIAutomationElement, runtimeId: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRuntimeId(self, runtimeId)
proc FindFirst*(self: ptr IUIAutomationElement, scope: TreeScope, condition: ptr IUIAutomationCondition, found: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindFirst(self, scope, condition, found)
proc FindAll*(self: ptr IUIAutomationElement, scope: TreeScope, condition: ptr IUIAutomationCondition, found: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindAll(self, scope, condition, found)
proc FindFirstBuildCache*(self: ptr IUIAutomationElement, scope: TreeScope, condition: ptr IUIAutomationCondition, cacheRequest: ptr IUIAutomationCacheRequest, found: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindFirstBuildCache(self, scope, condition, cacheRequest, found)
proc FindAllBuildCache*(self: ptr IUIAutomationElement, scope: TreeScope, condition: ptr IUIAutomationCondition, cacheRequest: ptr IUIAutomationCacheRequest, found: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindAllBuildCache(self, scope, condition, cacheRequest, found)
proc BuildUpdatedCache*(self: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, updatedElement: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.BuildUpdatedCache(self, cacheRequest, updatedElement)
proc GetCurrentPropertyValue*(self: ptr IUIAutomationElement, propertyId: PROPERTYID, retVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentPropertyValue(self, propertyId, retVal)
proc GetCurrentPropertyValueEx*(self: ptr IUIAutomationElement, propertyId: PROPERTYID, ignoreDefaultValue: BOOL, retVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentPropertyValueEx(self, propertyId, ignoreDefaultValue, retVal)
proc GetCachedPropertyValue*(self: ptr IUIAutomationElement, propertyId: PROPERTYID, retVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedPropertyValue(self, propertyId, retVal)
proc GetCachedPropertyValueEx*(self: ptr IUIAutomationElement, propertyId: PROPERTYID, ignoreDefaultValue: BOOL, retVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedPropertyValueEx(self, propertyId, ignoreDefaultValue, retVal)
proc GetCurrentPatternAs*(self: ptr IUIAutomationElement, patternId: PATTERNID, riid: REFIID, patternObject: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentPatternAs(self, patternId, riid, patternObject)
proc GetCachedPatternAs*(self: ptr IUIAutomationElement, patternId: PATTERNID, riid: REFIID, patternObject: ptr pointer): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedPatternAs(self, patternId, riid, patternObject)
proc GetCurrentPattern*(self: ptr IUIAutomationElement, patternId: PATTERNID, patternObject: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentPattern(self, patternId, patternObject)
proc GetCachedPattern*(self: ptr IUIAutomationElement, patternId: PATTERNID, patternObject: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedPattern(self, patternId, patternObject)
proc GetCachedParent*(self: ptr IUIAutomationElement, parent: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedParent(self, parent)
proc GetCachedChildren*(self: ptr IUIAutomationElement, children: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedChildren(self, children)
proc get_CurrentProcessId*(self: ptr IUIAutomationElement, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentProcessId(self, retVal)
proc get_CurrentControlType*(self: ptr IUIAutomationElement, retVal: ptr CONTROLTYPEID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentControlType(self, retVal)
proc get_CurrentLocalizedControlType*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentLocalizedControlType(self, retVal)
proc get_CurrentName*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentName(self, retVal)
proc get_CurrentAcceleratorKey*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentAcceleratorKey(self, retVal)
proc get_CurrentAccessKey*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentAccessKey(self, retVal)
proc get_CurrentHasKeyboardFocus*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentHasKeyboardFocus(self, retVal)
proc get_CurrentIsKeyboardFocusable*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsKeyboardFocusable(self, retVal)
proc get_CurrentIsEnabled*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsEnabled(self, retVal)
proc get_CurrentAutomationId*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentAutomationId(self, retVal)
proc get_CurrentClassName*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentClassName(self, retVal)
proc get_CurrentHelpText*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentHelpText(self, retVal)
proc get_CurrentCulture*(self: ptr IUIAutomationElement, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentCulture(self, retVal)
proc get_CurrentIsControlElement*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsControlElement(self, retVal)
proc get_CurrentIsContentElement*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsContentElement(self, retVal)
proc get_CurrentIsPassword*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsPassword(self, retVal)
proc get_CurrentNativeWindowHandle*(self: ptr IUIAutomationElement, retVal: ptr UIA_HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentNativeWindowHandle(self, retVal)
proc get_CurrentItemType*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentItemType(self, retVal)
proc get_CurrentIsOffscreen*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsOffscreen(self, retVal)
proc get_CurrentOrientation*(self: ptr IUIAutomationElement, retVal: ptr OrientationType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentOrientation(self, retVal)
proc get_CurrentFrameworkId*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentFrameworkId(self, retVal)
proc get_CurrentIsRequiredForForm*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsRequiredForForm(self, retVal)
proc get_CurrentItemStatus*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentItemStatus(self, retVal)
proc get_CurrentBoundingRectangle*(self: ptr IUIAutomationElement, retVal: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentBoundingRectangle(self, retVal)
proc get_CurrentLabeledBy*(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentLabeledBy(self, retVal)
proc get_CurrentAriaRole*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentAriaRole(self, retVal)
proc get_CurrentAriaProperties*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentAriaProperties(self, retVal)
proc get_CurrentIsDataValidForForm*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsDataValidForForm(self, retVal)
proc get_CurrentControllerFor*(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentControllerFor(self, retVal)
proc get_CurrentDescribedBy*(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentDescribedBy(self, retVal)
proc get_CurrentFlowsTo*(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentFlowsTo(self, retVal)
proc get_CurrentProviderDescription*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentProviderDescription(self, retVal)
proc get_CachedProcessId*(self: ptr IUIAutomationElement, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedProcessId(self, retVal)
proc get_CachedControlType*(self: ptr IUIAutomationElement, retVal: ptr CONTROLTYPEID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedControlType(self, retVal)
proc get_CachedLocalizedControlType*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedLocalizedControlType(self, retVal)
proc get_CachedName*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedName(self, retVal)
proc get_CachedAcceleratorKey*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedAcceleratorKey(self, retVal)
proc get_CachedAccessKey*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedAccessKey(self, retVal)
proc get_CachedHasKeyboardFocus*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedHasKeyboardFocus(self, retVal)
proc get_CachedIsKeyboardFocusable*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsKeyboardFocusable(self, retVal)
proc get_CachedIsEnabled*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsEnabled(self, retVal)
proc get_CachedAutomationId*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedAutomationId(self, retVal)
proc get_CachedClassName*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedClassName(self, retVal)
proc get_CachedHelpText*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedHelpText(self, retVal)
proc get_CachedCulture*(self: ptr IUIAutomationElement, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedCulture(self, retVal)
proc get_CachedIsControlElement*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsControlElement(self, retVal)
proc get_CachedIsContentElement*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsContentElement(self, retVal)
proc get_CachedIsPassword*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsPassword(self, retVal)
proc get_CachedNativeWindowHandle*(self: ptr IUIAutomationElement, retVal: ptr UIA_HWND): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedNativeWindowHandle(self, retVal)
proc get_CachedItemType*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedItemType(self, retVal)
proc get_CachedIsOffscreen*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsOffscreen(self, retVal)
proc get_CachedOrientation*(self: ptr IUIAutomationElement, retVal: ptr OrientationType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedOrientation(self, retVal)
proc get_CachedFrameworkId*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedFrameworkId(self, retVal)
proc get_CachedIsRequiredForForm*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsRequiredForForm(self, retVal)
proc get_CachedItemStatus*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedItemStatus(self, retVal)
proc get_CachedBoundingRectangle*(self: ptr IUIAutomationElement, retVal: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedBoundingRectangle(self, retVal)
proc get_CachedLabeledBy*(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedLabeledBy(self, retVal)
proc get_CachedAriaRole*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedAriaRole(self, retVal)
proc get_CachedAriaProperties*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedAriaProperties(self, retVal)
proc get_CachedIsDataValidForForm*(self: ptr IUIAutomationElement, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsDataValidForForm(self, retVal)
proc get_CachedControllerFor*(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedControllerFor(self, retVal)
proc get_CachedDescribedBy*(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedDescribedBy(self, retVal)
proc get_CachedFlowsTo*(self: ptr IUIAutomationElement, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedFlowsTo(self, retVal)
proc get_CachedProviderDescription*(self: ptr IUIAutomationElement, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedProviderDescription(self, retVal)
proc GetClickablePoint*(self: ptr IUIAutomationElement, clickable: ptr POINT, gotClickable: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetClickablePoint(self, clickable, gotClickable)
proc get_Length*(self: ptr IUIAutomationElementArray, length: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Length(self, length)
proc GetElement*(self: ptr IUIAutomationElementArray, index: int32, element: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetElement(self, index, element)
proc get_BooleanValue*(self: ptr IUIAutomationBoolCondition, boolVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_BooleanValue(self, boolVal)
proc get_PropertyId*(self: ptr IUIAutomationPropertyCondition, propertyId: ptr PROPERTYID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_PropertyId(self, propertyId)
proc get_PropertyValue*(self: ptr IUIAutomationPropertyCondition, propertyValue: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_PropertyValue(self, propertyValue)
proc get_PropertyConditionFlags*(self: ptr IUIAutomationPropertyCondition, flags: ptr PropertyConditionFlags): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_PropertyConditionFlags(self, flags)
proc get_ChildCount*(self: ptr IUIAutomationAndCondition, childCount: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ChildCount(self, childCount)
proc GetChildrenAsNativeArray*(self: ptr IUIAutomationAndCondition, childArray: ptr ptr ptr IUIAutomationCondition, childArrayCount: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetChildrenAsNativeArray(self, childArray, childArrayCount)
proc GetChildren*(self: ptr IUIAutomationAndCondition, childArray: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetChildren(self, childArray)
proc get_ChildCount*(self: ptr IUIAutomationOrCondition, childCount: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ChildCount(self, childCount)
proc GetChildrenAsNativeArray*(self: ptr IUIAutomationOrCondition, childArray: ptr ptr ptr IUIAutomationCondition, childArrayCount: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetChildrenAsNativeArray(self, childArray, childArrayCount)
proc GetChildren*(self: ptr IUIAutomationOrCondition, childArray: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetChildren(self, childArray)
proc GetChild*(self: ptr IUIAutomationNotCondition, condition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetChild(self, condition)
proc AddProperty*(self: ptr IUIAutomationCacheRequest, propertyId: PROPERTYID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddProperty(self, propertyId)
proc AddPattern*(self: ptr IUIAutomationCacheRequest, patternId: PATTERNID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddPattern(self, patternId)
proc Clone*(self: ptr IUIAutomationCacheRequest, clonedRequest: ptr ptr IUIAutomationCacheRequest): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, clonedRequest)
proc get_TreeScope*(self: ptr IUIAutomationCacheRequest, scope: ptr TreeScope): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_TreeScope(self, scope)
proc put_TreeScope*(self: ptr IUIAutomationCacheRequest, scope: TreeScope): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_TreeScope(self, scope)
proc get_TreeFilter*(self: ptr IUIAutomationCacheRequest, filter: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_TreeFilter(self, filter)
proc put_TreeFilter*(self: ptr IUIAutomationCacheRequest, filter: ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_TreeFilter(self, filter)
proc get_AutomationElementMode*(self: ptr IUIAutomationCacheRequest, mode: ptr AutomationElementMode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_AutomationElementMode(self, mode)
proc put_AutomationElementMode*(self: ptr IUIAutomationCacheRequest, mode: AutomationElementMode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_AutomationElementMode(self, mode)
proc GetParentElement*(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, parent: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetParentElement(self, element, parent)
proc GetFirstChildElement*(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, first: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFirstChildElement(self, element, first)
proc GetLastChildElement*(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, last: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLastChildElement(self, element, last)
proc GetNextSiblingElement*(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, next: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNextSiblingElement(self, element, next)
proc GetPreviousSiblingElement*(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, previous: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPreviousSiblingElement(self, element, previous)
proc NormalizeElement*(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, normalized: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NormalizeElement(self, element, normalized)
proc GetParentElementBuildCache*(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, parent: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetParentElementBuildCache(self, element, cacheRequest, parent)
proc GetFirstChildElementBuildCache*(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, first: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFirstChildElementBuildCache(self, element, cacheRequest, first)
proc GetLastChildElementBuildCache*(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, last: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLastChildElementBuildCache(self, element, cacheRequest, last)
proc GetNextSiblingElementBuildCache*(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, next: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNextSiblingElementBuildCache(self, element, cacheRequest, next)
proc GetPreviousSiblingElementBuildCache*(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, previous: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPreviousSiblingElementBuildCache(self, element, cacheRequest, previous)
proc NormalizeElementBuildCache*(self: ptr IUIAutomationTreeWalker, element: ptr IUIAutomationElement, cacheRequest: ptr IUIAutomationCacheRequest, normalized: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.NormalizeElementBuildCache(self, element, cacheRequest, normalized)
proc get_Condition*(self: ptr IUIAutomationTreeWalker, condition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Condition(self, condition)
proc HandleAutomationEvent*(self: ptr IUIAutomationEventHandler, sender: ptr IUIAutomationElement, eventId: EVENTID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleAutomationEvent(self, sender, eventId)
proc HandlePropertyChangedEvent*(self: ptr IUIAutomationPropertyChangedEventHandler, sender: ptr IUIAutomationElement, propertyId: PROPERTYID, newValue: VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandlePropertyChangedEvent(self, sender, propertyId, newValue)
proc HandleStructureChangedEvent*(self: ptr IUIAutomationStructureChangedEventHandler, sender: ptr IUIAutomationElement, changeType: StructureChangeType, runtimeId: ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleStructureChangedEvent(self, sender, changeType, runtimeId)
proc HandleFocusChangedEvent*(self: ptr IUIAutomationFocusChangedEventHandler, sender: ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleFocusChangedEvent(self, sender)
proc HandleTextEditTextChangedEvent*(self: ptr IUIAutomationTextEditTextChangedEventHandler, sender: ptr IUIAutomationElement, textEditChangeType: TextEditChangeType, eventStrings: ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleTextEditTextChangedEvent(self, sender, textEditChangeType, eventStrings)
proc HandleChangesEvent*(self: ptr IUIAutomationChangesEventHandler, sender: ptr IUIAutomationElement, uiaChanges: ptr UiaChangeInfo, changesCount: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleChangesEvent(self, sender, uiaChanges, changesCount)
proc HandleNotificationEvent*(self: ptr IUIAutomationNotificationEventHandler, sender: ptr IUIAutomationElement, notificationKind: NotificationKind, notificationProcessing: NotificationProcessing, displayString: BSTR, activityId: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleNotificationEvent(self, sender, notificationKind, notificationProcessing, displayString, activityId)
proc Invoke*(self: ptr IUIAutomationInvokePattern): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Invoke(self)
proc SetDockPosition*(self: ptr IUIAutomationDockPattern, dockPos: DockPosition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDockPosition(self, dockPos)
proc get_CurrentDockPosition*(self: ptr IUIAutomationDockPattern, retVal: ptr DockPosition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentDockPosition(self, retVal)
proc get_CachedDockPosition*(self: ptr IUIAutomationDockPattern, retVal: ptr DockPosition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedDockPosition(self, retVal)
proc Expand*(self: ptr IUIAutomationExpandCollapsePattern): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Expand(self)
proc Collapse*(self: ptr IUIAutomationExpandCollapsePattern): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Collapse(self)
proc get_CurrentExpandCollapseState*(self: ptr IUIAutomationExpandCollapsePattern, retVal: ptr ExpandCollapseState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentExpandCollapseState(self, retVal)
proc get_CachedExpandCollapseState*(self: ptr IUIAutomationExpandCollapsePattern, retVal: ptr ExpandCollapseState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedExpandCollapseState(self, retVal)
proc GetItem*(self: ptr IUIAutomationGridPattern, row: int32, column: int32, element: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItem(self, row, column, element)
proc get_CurrentRowCount*(self: ptr IUIAutomationGridPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentRowCount(self, retVal)
proc get_CurrentColumnCount*(self: ptr IUIAutomationGridPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentColumnCount(self, retVal)
proc get_CachedRowCount*(self: ptr IUIAutomationGridPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedRowCount(self, retVal)
proc get_CachedColumnCount*(self: ptr IUIAutomationGridPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedColumnCount(self, retVal)
proc get_CurrentContainingGrid*(self: ptr IUIAutomationGridItemPattern, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentContainingGrid(self, retVal)
proc get_CurrentRow*(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentRow(self, retVal)
proc get_CurrentColumn*(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentColumn(self, retVal)
proc get_CurrentRowSpan*(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentRowSpan(self, retVal)
proc get_CurrentColumnSpan*(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentColumnSpan(self, retVal)
proc get_CachedContainingGrid*(self: ptr IUIAutomationGridItemPattern, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedContainingGrid(self, retVal)
proc get_CachedRow*(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedRow(self, retVal)
proc get_CachedColumn*(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedColumn(self, retVal)
proc get_CachedRowSpan*(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedRowSpan(self, retVal)
proc get_CachedColumnSpan*(self: ptr IUIAutomationGridItemPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedColumnSpan(self, retVal)
proc GetViewName*(self: ptr IUIAutomationMultipleViewPattern, view: int32, name: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetViewName(self, view, name)
proc SetCurrentView*(self: ptr IUIAutomationMultipleViewPattern, view: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetCurrentView(self, view)
proc get_CurrentCurrentView*(self: ptr IUIAutomationMultipleViewPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentCurrentView(self, retVal)
proc GetCurrentSupportedViews*(self: ptr IUIAutomationMultipleViewPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentSupportedViews(self, retVal)
proc get_CachedCurrentView*(self: ptr IUIAutomationMultipleViewPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedCurrentView(self, retVal)
proc GetCachedSupportedViews*(self: ptr IUIAutomationMultipleViewPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedSupportedViews(self, retVal)
proc GetUnderlyingObjectModel*(self: ptr IUIAutomationObjectModelPattern, retVal: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetUnderlyingObjectModel(self, retVal)
proc SetValue*(self: ptr IUIAutomationRangeValuePattern, val: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetValue(self, val)
proc get_CurrentValue*(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentValue(self, retVal)
proc get_CurrentIsReadOnly*(self: ptr IUIAutomationRangeValuePattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsReadOnly(self, retVal)
proc get_CurrentMaximum*(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentMaximum(self, retVal)
proc get_CurrentMinimum*(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentMinimum(self, retVal)
proc get_CurrentLargeChange*(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentLargeChange(self, retVal)
proc get_CurrentSmallChange*(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentSmallChange(self, retVal)
proc get_CachedValue*(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedValue(self, retVal)
proc get_CachedIsReadOnly*(self: ptr IUIAutomationRangeValuePattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsReadOnly(self, retVal)
proc get_CachedMaximum*(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedMaximum(self, retVal)
proc get_CachedMinimum*(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedMinimum(self, retVal)
proc get_CachedLargeChange*(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedLargeChange(self, retVal)
proc get_CachedSmallChange*(self: ptr IUIAutomationRangeValuePattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedSmallChange(self, retVal)
proc Scroll*(self: ptr IUIAutomationScrollPattern, horizontalAmount: ScrollAmount, verticalAmount: ScrollAmount): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Scroll(self, horizontalAmount, verticalAmount)
proc SetScrollPercent*(self: ptr IUIAutomationScrollPattern, horizontalPercent: float64, verticalPercent: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetScrollPercent(self, horizontalPercent, verticalPercent)
proc get_CurrentHorizontalScrollPercent*(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentHorizontalScrollPercent(self, retVal)
proc get_CurrentVerticalScrollPercent*(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentVerticalScrollPercent(self, retVal)
proc get_CurrentHorizontalViewSize*(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentHorizontalViewSize(self, retVal)
proc get_CurrentVerticalViewSize*(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentVerticalViewSize(self, retVal)
proc get_CurrentHorizontallyScrollable*(self: ptr IUIAutomationScrollPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentHorizontallyScrollable(self, retVal)
proc get_CurrentVerticallyScrollable*(self: ptr IUIAutomationScrollPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentVerticallyScrollable(self, retVal)
proc get_CachedHorizontalScrollPercent*(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedHorizontalScrollPercent(self, retVal)
proc get_CachedVerticalScrollPercent*(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedVerticalScrollPercent(self, retVal)
proc get_CachedHorizontalViewSize*(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedHorizontalViewSize(self, retVal)
proc get_CachedVerticalViewSize*(self: ptr IUIAutomationScrollPattern, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedVerticalViewSize(self, retVal)
proc get_CachedHorizontallyScrollable*(self: ptr IUIAutomationScrollPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedHorizontallyScrollable(self, retVal)
proc get_CachedVerticallyScrollable*(self: ptr IUIAutomationScrollPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedVerticallyScrollable(self, retVal)
proc ScrollIntoView*(self: ptr IUIAutomationScrollItemPattern): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ScrollIntoView(self)
proc GetCurrentSelection*(self: ptr IUIAutomationSelectionPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentSelection(self, retVal)
proc get_CurrentCanSelectMultiple*(self: ptr IUIAutomationSelectionPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentCanSelectMultiple(self, retVal)
proc get_CurrentIsSelectionRequired*(self: ptr IUIAutomationSelectionPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsSelectionRequired(self, retVal)
proc GetCachedSelection*(self: ptr IUIAutomationSelectionPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedSelection(self, retVal)
proc get_CachedCanSelectMultiple*(self: ptr IUIAutomationSelectionPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedCanSelectMultiple(self, retVal)
proc get_CachedIsSelectionRequired*(self: ptr IUIAutomationSelectionPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsSelectionRequired(self, retVal)
proc get_CurrentFirstSelectedItem*(self: ptr IUIAutomationSelectionPattern2, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentFirstSelectedItem(self, retVal)
proc get_CurrentLastSelectedItem*(self: ptr IUIAutomationSelectionPattern2, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentLastSelectedItem(self, retVal)
proc get_CurrentCurrentSelectedItem*(self: ptr IUIAutomationSelectionPattern2, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentCurrentSelectedItem(self, retVal)
proc get_CurrentItemCount*(self: ptr IUIAutomationSelectionPattern2, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentItemCount(self, retVal)
proc get_CachedFirstSelectedItem*(self: ptr IUIAutomationSelectionPattern2, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedFirstSelectedItem(self, retVal)
proc get_CachedLastSelectedItem*(self: ptr IUIAutomationSelectionPattern2, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedLastSelectedItem(self, retVal)
proc get_CachedCurrentSelectedItem*(self: ptr IUIAutomationSelectionPattern2, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedCurrentSelectedItem(self, retVal)
proc get_CachedItemCount*(self: ptr IUIAutomationSelectionPattern2, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedItemCount(self, retVal)
proc Select*(self: ptr IUIAutomationSelectionItemPattern): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Select(self)
proc AddToSelection*(self: ptr IUIAutomationSelectionItemPattern): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddToSelection(self)
proc RemoveFromSelection*(self: ptr IUIAutomationSelectionItemPattern): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveFromSelection(self)
proc get_CurrentIsSelected*(self: ptr IUIAutomationSelectionItemPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsSelected(self, retVal)
proc get_CurrentSelectionContainer*(self: ptr IUIAutomationSelectionItemPattern, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentSelectionContainer(self, retVal)
proc get_CachedIsSelected*(self: ptr IUIAutomationSelectionItemPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsSelected(self, retVal)
proc get_CachedSelectionContainer*(self: ptr IUIAutomationSelectionItemPattern, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedSelectionContainer(self, retVal)
proc StartListening*(self: ptr IUIAutomationSynchronizedInputPattern, inputType: SynchronizedInputType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.StartListening(self, inputType)
proc Cancel*(self: ptr IUIAutomationSynchronizedInputPattern): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Cancel(self)
proc GetCurrentRowHeaders*(self: ptr IUIAutomationTablePattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentRowHeaders(self, retVal)
proc GetCurrentColumnHeaders*(self: ptr IUIAutomationTablePattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentColumnHeaders(self, retVal)
proc get_CurrentRowOrColumnMajor*(self: ptr IUIAutomationTablePattern, retVal: ptr RowOrColumnMajor): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentRowOrColumnMajor(self, retVal)
proc GetCachedRowHeaders*(self: ptr IUIAutomationTablePattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedRowHeaders(self, retVal)
proc GetCachedColumnHeaders*(self: ptr IUIAutomationTablePattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedColumnHeaders(self, retVal)
proc get_CachedRowOrColumnMajor*(self: ptr IUIAutomationTablePattern, retVal: ptr RowOrColumnMajor): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedRowOrColumnMajor(self, retVal)
proc GetCurrentRowHeaderItems*(self: ptr IUIAutomationTableItemPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentRowHeaderItems(self, retVal)
proc GetCurrentColumnHeaderItems*(self: ptr IUIAutomationTableItemPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentColumnHeaderItems(self, retVal)
proc GetCachedRowHeaderItems*(self: ptr IUIAutomationTableItemPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedRowHeaderItems(self, retVal)
proc GetCachedColumnHeaderItems*(self: ptr IUIAutomationTableItemPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedColumnHeaderItems(self, retVal)
proc Toggle*(self: ptr IUIAutomationTogglePattern): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Toggle(self)
proc get_CurrentToggleState*(self: ptr IUIAutomationTogglePattern, retVal: ptr ToggleState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentToggleState(self, retVal)
proc get_CachedToggleState*(self: ptr IUIAutomationTogglePattern, retVal: ptr ToggleState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedToggleState(self, retVal)
proc Move*(self: ptr IUIAutomationTransformPattern, x: float64, y: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Move(self, x, y)
proc Resize*(self: ptr IUIAutomationTransformPattern, width: float64, height: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Resize(self, width, height)
proc Rotate*(self: ptr IUIAutomationTransformPattern, degrees: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Rotate(self, degrees)
proc get_CurrentCanMove*(self: ptr IUIAutomationTransformPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentCanMove(self, retVal)
proc get_CurrentCanResize*(self: ptr IUIAutomationTransformPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentCanResize(self, retVal)
proc get_CurrentCanRotate*(self: ptr IUIAutomationTransformPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentCanRotate(self, retVal)
proc get_CachedCanMove*(self: ptr IUIAutomationTransformPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedCanMove(self, retVal)
proc get_CachedCanResize*(self: ptr IUIAutomationTransformPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedCanResize(self, retVal)
proc get_CachedCanRotate*(self: ptr IUIAutomationTransformPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedCanRotate(self, retVal)
proc SetValue*(self: ptr IUIAutomationValuePattern, val: BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetValue(self, val)
proc get_CurrentValue*(self: ptr IUIAutomationValuePattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentValue(self, retVal)
proc get_CurrentIsReadOnly*(self: ptr IUIAutomationValuePattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsReadOnly(self, retVal)
proc get_CachedValue*(self: ptr IUIAutomationValuePattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedValue(self, retVal)
proc get_CachedIsReadOnly*(self: ptr IUIAutomationValuePattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsReadOnly(self, retVal)
proc Close*(self: ptr IUIAutomationWindowPattern): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Close(self)
proc WaitForInputIdle*(self: ptr IUIAutomationWindowPattern, milliseconds: int32, success: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WaitForInputIdle(self, milliseconds, success)
proc SetWindowVisualState*(self: ptr IUIAutomationWindowPattern, state: WindowVisualState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetWindowVisualState(self, state)
proc get_CurrentCanMaximize*(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentCanMaximize(self, retVal)
proc get_CurrentCanMinimize*(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentCanMinimize(self, retVal)
proc get_CurrentIsModal*(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsModal(self, retVal)
proc get_CurrentIsTopmost*(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsTopmost(self, retVal)
proc get_CurrentWindowVisualState*(self: ptr IUIAutomationWindowPattern, retVal: ptr WindowVisualState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentWindowVisualState(self, retVal)
proc get_CurrentWindowInteractionState*(self: ptr IUIAutomationWindowPattern, retVal: ptr WindowInteractionState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentWindowInteractionState(self, retVal)
proc get_CachedCanMaximize*(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedCanMaximize(self, retVal)
proc get_CachedCanMinimize*(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedCanMinimize(self, retVal)
proc get_CachedIsModal*(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsModal(self, retVal)
proc get_CachedIsTopmost*(self: ptr IUIAutomationWindowPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsTopmost(self, retVal)
proc get_CachedWindowVisualState*(self: ptr IUIAutomationWindowPattern, retVal: ptr WindowVisualState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedWindowVisualState(self, retVal)
proc get_CachedWindowInteractionState*(self: ptr IUIAutomationWindowPattern, retVal: ptr WindowInteractionState): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedWindowInteractionState(self, retVal)
proc Clone*(self: ptr IUIAutomationTextRange, clonedRange: ptr ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, clonedRange)
proc Compare*(self: ptr IUIAutomationTextRange, range: ptr IUIAutomationTextRange, areSame: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Compare(self, range, areSame)
proc CompareEndpoints*(self: ptr IUIAutomationTextRange, srcEndPoint: TextPatternRangeEndpoint, range: ptr IUIAutomationTextRange, targetEndPoint: TextPatternRangeEndpoint, compValue: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CompareEndpoints(self, srcEndPoint, range, targetEndPoint, compValue)
proc ExpandToEnclosingUnit*(self: ptr IUIAutomationTextRange, textUnit: TextUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ExpandToEnclosingUnit(self, textUnit)
proc FindAttribute*(self: ptr IUIAutomationTextRange, attr: TEXTATTRIBUTEID, val: VARIANT, backward: BOOL, found: ptr ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindAttribute(self, attr, val, backward, found)
proc FindText*(self: ptr IUIAutomationTextRange, text: BSTR, backward: BOOL, ignoreCase: BOOL, found: ptr ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindText(self, text, backward, ignoreCase, found)
proc GetAttributeValue*(self: ptr IUIAutomationTextRange, attr: TEXTATTRIBUTEID, value: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAttributeValue(self, attr, value)
proc GetBoundingRectangles*(self: ptr IUIAutomationTextRange, boundingRects: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBoundingRectangles(self, boundingRects)
proc GetEnclosingElement*(self: ptr IUIAutomationTextRange, enclosingElement: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEnclosingElement(self, enclosingElement)
proc GetText*(self: ptr IUIAutomationTextRange, maxLength: int32, text: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetText(self, maxLength, text)
proc Move*(self: ptr IUIAutomationTextRange, unit: TextUnit, count: int32, moved: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Move(self, unit, count, moved)
proc MoveEndpointByUnit*(self: ptr IUIAutomationTextRange, endpoint: TextPatternRangeEndpoint, unit: TextUnit, count: int32, moved: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveEndpointByUnit(self, endpoint, unit, count, moved)
proc MoveEndpointByRange*(self: ptr IUIAutomationTextRange, srcEndPoint: TextPatternRangeEndpoint, range: ptr IUIAutomationTextRange, targetEndPoint: TextPatternRangeEndpoint): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MoveEndpointByRange(self, srcEndPoint, range, targetEndPoint)
proc Select*(self: ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Select(self)
proc AddToSelection*(self: ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddToSelection(self)
proc RemoveFromSelection*(self: ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveFromSelection(self)
proc ScrollIntoView*(self: ptr IUIAutomationTextRange, alignToTop: BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ScrollIntoView(self, alignToTop)
proc GetChildren*(self: ptr IUIAutomationTextRange, children: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetChildren(self, children)
proc ShowContextMenu*(self: ptr IUIAutomationTextRange2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowContextMenu(self)
proc GetEnclosingElementBuildCache*(self: ptr IUIAutomationTextRange3, cacheRequest: ptr IUIAutomationCacheRequest, enclosingElement: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEnclosingElementBuildCache(self, cacheRequest, enclosingElement)
proc GetChildrenBuildCache*(self: ptr IUIAutomationTextRange3, cacheRequest: ptr IUIAutomationCacheRequest, children: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetChildrenBuildCache(self, cacheRequest, children)
proc GetAttributeValues*(self: ptr IUIAutomationTextRange3, attributeIds: ptr TEXTATTRIBUTEID, attributeIdCount: int32, attributeValues: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAttributeValues(self, attributeIds, attributeIdCount, attributeValues)
proc get_Length*(self: ptr IUIAutomationTextRangeArray, length: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Length(self, length)
proc GetElement*(self: ptr IUIAutomationTextRangeArray, index: int32, element: ptr ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetElement(self, index, element)
proc RangeFromPoint*(self: ptr IUIAutomationTextPattern, pt: POINT, range: ptr ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RangeFromPoint(self, pt, range)
proc RangeFromChild*(self: ptr IUIAutomationTextPattern, child: ptr IUIAutomationElement, range: ptr ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RangeFromChild(self, child, range)
proc GetSelection*(self: ptr IUIAutomationTextPattern, ranges: ptr ptr IUIAutomationTextRangeArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSelection(self, ranges)
proc GetVisibleRanges*(self: ptr IUIAutomationTextPattern, ranges: ptr ptr IUIAutomationTextRangeArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetVisibleRanges(self, ranges)
proc get_DocumentRange*(self: ptr IUIAutomationTextPattern, range: ptr ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_DocumentRange(self, range)
proc get_SupportedTextSelection*(self: ptr IUIAutomationTextPattern, supportedTextSelection: ptr SupportedTextSelection): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_SupportedTextSelection(self, supportedTextSelection)
proc RangeFromAnnotation*(self: ptr IUIAutomationTextPattern2, annotation: ptr IUIAutomationElement, range: ptr ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RangeFromAnnotation(self, annotation, range)
proc GetCaretRange*(self: ptr IUIAutomationTextPattern2, isActive: ptr BOOL, range: ptr ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCaretRange(self, isActive, range)
proc GetActiveComposition*(self: ptr IUIAutomationTextEditPattern, range: ptr ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetActiveComposition(self, range)
proc GetConversionTarget*(self: ptr IUIAutomationTextEditPattern, range: ptr ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetConversionTarget(self, range)
proc Navigate*(self: ptr IUIAutomationCustomNavigationPattern, direction: NavigateDirection, pRetVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Navigate(self, direction, pRetVal)
proc HandleActiveTextPositionChangedEvent*(self: ptr IUIAutomationActiveTextPositionChangedEventHandler, sender: ptr IUIAutomationElement, range: ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandleActiveTextPositionChangedEvent(self, sender, range)
proc Select*(self: ptr IUIAutomationLegacyIAccessiblePattern, flagsSelect: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Select(self, flagsSelect)
proc DoDefaultAction*(self: ptr IUIAutomationLegacyIAccessiblePattern): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoDefaultAction(self)
proc SetValue*(self: ptr IUIAutomationLegacyIAccessiblePattern, szValue: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetValue(self, szValue)
proc get_CurrentChildId*(self: ptr IUIAutomationLegacyIAccessiblePattern, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentChildId(self, pRetVal)
proc get_CurrentName*(self: ptr IUIAutomationLegacyIAccessiblePattern, pszName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentName(self, pszName)
proc get_CurrentValue*(self: ptr IUIAutomationLegacyIAccessiblePattern, pszValue: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentValue(self, pszValue)
proc get_CurrentDescription*(self: ptr IUIAutomationLegacyIAccessiblePattern, pszDescription: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentDescription(self, pszDescription)
proc get_CurrentRole*(self: ptr IUIAutomationLegacyIAccessiblePattern, pdwRole: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentRole(self, pdwRole)
proc get_CurrentState*(self: ptr IUIAutomationLegacyIAccessiblePattern, pdwState: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentState(self, pdwState)
proc get_CurrentHelp*(self: ptr IUIAutomationLegacyIAccessiblePattern, pszHelp: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentHelp(self, pszHelp)
proc get_CurrentKeyboardShortcut*(self: ptr IUIAutomationLegacyIAccessiblePattern, pszKeyboardShortcut: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentKeyboardShortcut(self, pszKeyboardShortcut)
proc GetCurrentSelection*(self: ptr IUIAutomationLegacyIAccessiblePattern, pvarSelectedChildren: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentSelection(self, pvarSelectedChildren)
proc get_CurrentDefaultAction*(self: ptr IUIAutomationLegacyIAccessiblePattern, pszDefaultAction: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentDefaultAction(self, pszDefaultAction)
proc get_CachedChildId*(self: ptr IUIAutomationLegacyIAccessiblePattern, pRetVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedChildId(self, pRetVal)
proc get_CachedName*(self: ptr IUIAutomationLegacyIAccessiblePattern, pszName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedName(self, pszName)
proc get_CachedValue*(self: ptr IUIAutomationLegacyIAccessiblePattern, pszValue: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedValue(self, pszValue)
proc get_CachedDescription*(self: ptr IUIAutomationLegacyIAccessiblePattern, pszDescription: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedDescription(self, pszDescription)
proc get_CachedRole*(self: ptr IUIAutomationLegacyIAccessiblePattern, pdwRole: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedRole(self, pdwRole)
proc get_CachedState*(self: ptr IUIAutomationLegacyIAccessiblePattern, pdwState: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedState(self, pdwState)
proc get_CachedHelp*(self: ptr IUIAutomationLegacyIAccessiblePattern, pszHelp: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedHelp(self, pszHelp)
proc get_CachedKeyboardShortcut*(self: ptr IUIAutomationLegacyIAccessiblePattern, pszKeyboardShortcut: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedKeyboardShortcut(self, pszKeyboardShortcut)
proc GetCachedSelection*(self: ptr IUIAutomationLegacyIAccessiblePattern, pvarSelectedChildren: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedSelection(self, pvarSelectedChildren)
proc get_CachedDefaultAction*(self: ptr IUIAutomationLegacyIAccessiblePattern, pszDefaultAction: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedDefaultAction(self, pszDefaultAction)
proc GetIAccessible*(self: ptr IUIAutomationLegacyIAccessiblePattern, ppAccessible: ptr ptr IAccessible): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetIAccessible(self, ppAccessible)
proc FindItemByProperty*(self: ptr IUIAutomationItemContainerPattern, pStartAfter: ptr IUIAutomationElement, propertyId: PROPERTYID, value: VARIANT, pFound: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindItemByProperty(self, pStartAfter, propertyId, value, pFound)
proc Realize*(self: ptr IUIAutomationVirtualizedItemPattern): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Realize(self)
proc get_CurrentAnnotationTypeId*(self: ptr IUIAutomationAnnotationPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentAnnotationTypeId(self, retVal)
proc get_CurrentAnnotationTypeName*(self: ptr IUIAutomationAnnotationPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentAnnotationTypeName(self, retVal)
proc get_CurrentAuthor*(self: ptr IUIAutomationAnnotationPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentAuthor(self, retVal)
proc get_CurrentDateTime*(self: ptr IUIAutomationAnnotationPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentDateTime(self, retVal)
proc get_CurrentTarget*(self: ptr IUIAutomationAnnotationPattern, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentTarget(self, retVal)
proc get_CachedAnnotationTypeId*(self: ptr IUIAutomationAnnotationPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedAnnotationTypeId(self, retVal)
proc get_CachedAnnotationTypeName*(self: ptr IUIAutomationAnnotationPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedAnnotationTypeName(self, retVal)
proc get_CachedAuthor*(self: ptr IUIAutomationAnnotationPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedAuthor(self, retVal)
proc get_CachedDateTime*(self: ptr IUIAutomationAnnotationPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedDateTime(self, retVal)
proc get_CachedTarget*(self: ptr IUIAutomationAnnotationPattern, retVal: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedTarget(self, retVal)
proc get_CurrentStyleId*(self: ptr IUIAutomationStylesPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentStyleId(self, retVal)
proc get_CurrentStyleName*(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentStyleName(self, retVal)
proc get_CurrentFillColor*(self: ptr IUIAutomationStylesPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentFillColor(self, retVal)
proc get_CurrentFillPatternStyle*(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentFillPatternStyle(self, retVal)
proc get_CurrentShape*(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentShape(self, retVal)
proc get_CurrentFillPatternColor*(self: ptr IUIAutomationStylesPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentFillPatternColor(self, retVal)
proc get_CurrentExtendedProperties*(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentExtendedProperties(self, retVal)
proc GetCurrentExtendedPropertiesAsArray*(self: ptr IUIAutomationStylesPattern, propertyArray: ptr ptr TExtendedProperty, propertyCount: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentExtendedPropertiesAsArray(self, propertyArray, propertyCount)
proc get_CachedStyleId*(self: ptr IUIAutomationStylesPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedStyleId(self, retVal)
proc get_CachedStyleName*(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedStyleName(self, retVal)
proc get_CachedFillColor*(self: ptr IUIAutomationStylesPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedFillColor(self, retVal)
proc get_CachedFillPatternStyle*(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedFillPatternStyle(self, retVal)
proc get_CachedShape*(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedShape(self, retVal)
proc get_CachedFillPatternColor*(self: ptr IUIAutomationStylesPattern, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedFillPatternColor(self, retVal)
proc get_CachedExtendedProperties*(self: ptr IUIAutomationStylesPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedExtendedProperties(self, retVal)
proc GetCachedExtendedPropertiesAsArray*(self: ptr IUIAutomationStylesPattern, propertyArray: ptr ptr TExtendedProperty, propertyCount: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedExtendedPropertiesAsArray(self, propertyArray, propertyCount)
proc GetItemByName*(self: ptr IUIAutomationSpreadsheetPattern, name: BSTR, element: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetItemByName(self, name, element)
proc get_CurrentFormula*(self: ptr IUIAutomationSpreadsheetItemPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentFormula(self, retVal)
proc GetCurrentAnnotationObjects*(self: ptr IUIAutomationSpreadsheetItemPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentAnnotationObjects(self, retVal)
proc GetCurrentAnnotationTypes*(self: ptr IUIAutomationSpreadsheetItemPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentAnnotationTypes(self, retVal)
proc get_CachedFormula*(self: ptr IUIAutomationSpreadsheetItemPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedFormula(self, retVal)
proc GetCachedAnnotationObjects*(self: ptr IUIAutomationSpreadsheetItemPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedAnnotationObjects(self, retVal)
proc GetCachedAnnotationTypes*(self: ptr IUIAutomationSpreadsheetItemPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedAnnotationTypes(self, retVal)
proc Zoom*(self: ptr IUIAutomationTransformPattern2, zoomValue: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Zoom(self, zoomValue)
proc ZoomByUnit*(self: ptr IUIAutomationTransformPattern2, zoomUnit: ZoomUnit): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ZoomByUnit(self, zoomUnit)
proc get_CurrentCanZoom*(self: ptr IUIAutomationTransformPattern2, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentCanZoom(self, retVal)
proc get_CachedCanZoom*(self: ptr IUIAutomationTransformPattern2, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedCanZoom(self, retVal)
proc get_CurrentZoomLevel*(self: ptr IUIAutomationTransformPattern2, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentZoomLevel(self, retVal)
proc get_CachedZoomLevel*(self: ptr IUIAutomationTransformPattern2, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedZoomLevel(self, retVal)
proc get_CurrentZoomMinimum*(self: ptr IUIAutomationTransformPattern2, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentZoomMinimum(self, retVal)
proc get_CachedZoomMinimum*(self: ptr IUIAutomationTransformPattern2, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedZoomMinimum(self, retVal)
proc get_CurrentZoomMaximum*(self: ptr IUIAutomationTransformPattern2, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentZoomMaximum(self, retVal)
proc get_CachedZoomMaximum*(self: ptr IUIAutomationTransformPattern2, retVal: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedZoomMaximum(self, retVal)
proc get_TextContainer*(self: ptr IUIAutomationTextChildPattern, container: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_TextContainer(self, container)
proc get_TextRange*(self: ptr IUIAutomationTextChildPattern, range: ptr ptr IUIAutomationTextRange): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_TextRange(self, range)
proc get_CurrentIsGrabbed*(self: ptr IUIAutomationDragPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsGrabbed(self, retVal)
proc get_CachedIsGrabbed*(self: ptr IUIAutomationDragPattern, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsGrabbed(self, retVal)
proc get_CurrentDropEffect*(self: ptr IUIAutomationDragPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentDropEffect(self, retVal)
proc get_CachedDropEffect*(self: ptr IUIAutomationDragPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedDropEffect(self, retVal)
proc get_CurrentDropEffects*(self: ptr IUIAutomationDragPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentDropEffects(self, retVal)
proc get_CachedDropEffects*(self: ptr IUIAutomationDragPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedDropEffects(self, retVal)
proc GetCurrentGrabbedItems*(self: ptr IUIAutomationDragPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentGrabbedItems(self, retVal)
proc GetCachedGrabbedItems*(self: ptr IUIAutomationDragPattern, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCachedGrabbedItems(self, retVal)
proc get_CurrentDropTargetEffect*(self: ptr IUIAutomationDropTargetPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentDropTargetEffect(self, retVal)
proc get_CachedDropTargetEffect*(self: ptr IUIAutomationDropTargetPattern, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedDropTargetEffect(self, retVal)
proc get_CurrentDropTargetEffects*(self: ptr IUIAutomationDropTargetPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentDropTargetEffects(self, retVal)
proc get_CachedDropTargetEffects*(self: ptr IUIAutomationDropTargetPattern, retVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedDropTargetEffects(self, retVal)
proc get_CurrentOptimizeForVisualContent*(self: ptr IUIAutomationElement2, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentOptimizeForVisualContent(self, retVal)
proc get_CachedOptimizeForVisualContent*(self: ptr IUIAutomationElement2, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedOptimizeForVisualContent(self, retVal)
proc get_CurrentLiveSetting*(self: ptr IUIAutomationElement2, retVal: ptr LiveSetting): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentLiveSetting(self, retVal)
proc get_CachedLiveSetting*(self: ptr IUIAutomationElement2, retVal: ptr LiveSetting): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedLiveSetting(self, retVal)
proc get_CurrentFlowsFrom*(self: ptr IUIAutomationElement2, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentFlowsFrom(self, retVal)
proc get_CachedFlowsFrom*(self: ptr IUIAutomationElement2, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedFlowsFrom(self, retVal)
proc ShowContextMenu*(self: ptr IUIAutomationElement3): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowContextMenu(self)
proc get_CurrentIsPeripheral*(self: ptr IUIAutomationElement3, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsPeripheral(self, retVal)
proc get_CachedIsPeripheral*(self: ptr IUIAutomationElement3, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsPeripheral(self, retVal)
proc get_CurrentPositionInSet*(self: ptr IUIAutomationElement4, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentPositionInSet(self, retVal)
proc get_CurrentSizeOfSet*(self: ptr IUIAutomationElement4, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentSizeOfSet(self, retVal)
proc get_CurrentLevel*(self: ptr IUIAutomationElement4, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentLevel(self, retVal)
proc get_CurrentAnnotationTypes*(self: ptr IUIAutomationElement4, retVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentAnnotationTypes(self, retVal)
proc get_CurrentAnnotationObjects*(self: ptr IUIAutomationElement4, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentAnnotationObjects(self, retVal)
proc get_CachedPositionInSet*(self: ptr IUIAutomationElement4, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedPositionInSet(self, retVal)
proc get_CachedSizeOfSet*(self: ptr IUIAutomationElement4, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedSizeOfSet(self, retVal)
proc get_CachedLevel*(self: ptr IUIAutomationElement4, retVal: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedLevel(self, retVal)
proc get_CachedAnnotationTypes*(self: ptr IUIAutomationElement4, retVal: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedAnnotationTypes(self, retVal)
proc get_CachedAnnotationObjects*(self: ptr IUIAutomationElement4, retVal: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedAnnotationObjects(self, retVal)
proc get_CurrentLandmarkType*(self: ptr IUIAutomationElement5, retVal: ptr LANDMARKTYPEID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentLandmarkType(self, retVal)
proc get_CurrentLocalizedLandmarkType*(self: ptr IUIAutomationElement5, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentLocalizedLandmarkType(self, retVal)
proc get_CachedLandmarkType*(self: ptr IUIAutomationElement5, retVal: ptr LANDMARKTYPEID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedLandmarkType(self, retVal)
proc get_CachedLocalizedLandmarkType*(self: ptr IUIAutomationElement5, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedLocalizedLandmarkType(self, retVal)
proc get_CurrentFullDescription*(self: ptr IUIAutomationElement6, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentFullDescription(self, retVal)
proc get_CachedFullDescription*(self: ptr IUIAutomationElement6, retVal: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedFullDescription(self, retVal)
proc FindFirstWithOptions*(self: ptr IUIAutomationElement7, scope: TreeScope, condition: ptr IUIAutomationCondition, traversalOptions: TreeTraversalOptions, root: ptr IUIAutomationElement, found: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindFirstWithOptions(self, scope, condition, traversalOptions, root, found)
proc FindAllWithOptions*(self: ptr IUIAutomationElement7, scope: TreeScope, condition: ptr IUIAutomationCondition, traversalOptions: TreeTraversalOptions, root: ptr IUIAutomationElement, found: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindAllWithOptions(self, scope, condition, traversalOptions, root, found)
proc FindFirstWithOptionsBuildCache*(self: ptr IUIAutomationElement7, scope: TreeScope, condition: ptr IUIAutomationCondition, cacheRequest: ptr IUIAutomationCacheRequest, traversalOptions: TreeTraversalOptions, root: ptr IUIAutomationElement, found: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindFirstWithOptionsBuildCache(self, scope, condition, cacheRequest, traversalOptions, root, found)
proc FindAllWithOptionsBuildCache*(self: ptr IUIAutomationElement7, scope: TreeScope, condition: ptr IUIAutomationCondition, cacheRequest: ptr IUIAutomationCacheRequest, traversalOptions: TreeTraversalOptions, root: ptr IUIAutomationElement, found: ptr ptr IUIAutomationElementArray): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.FindAllWithOptionsBuildCache(self, scope, condition, cacheRequest, traversalOptions, root, found)
proc GetCurrentMetadataValue*(self: ptr IUIAutomationElement7, targetId: int32, metadataId: METADATAID, returnVal: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCurrentMetadataValue(self, targetId, metadataId, returnVal)
proc get_CurrentHeadingLevel*(self: ptr IUIAutomationElement8, retVal: ptr HEADINGLEVELID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentHeadingLevel(self, retVal)
proc get_CachedHeadingLevel*(self: ptr IUIAutomationElement8, retVal: ptr HEADINGLEVELID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedHeadingLevel(self, retVal)
proc get_CurrentIsDialog*(self: ptr IUIAutomationElement9, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CurrentIsDialog(self, retVal)
proc get_CachedIsDialog*(self: ptr IUIAutomationElement9, retVal: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CachedIsDialog(self, retVal)
proc CreateProvider*(self: ptr IUIAutomationProxyFactory, hwnd: UIA_HWND, idObject: LONG, idChild: LONG, provider: ptr ptr IRawElementProviderSimple): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateProvider(self, hwnd, idObject, idChild, provider)
proc get_ProxyFactoryId*(self: ptr IUIAutomationProxyFactory, factoryId: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ProxyFactoryId(self, factoryId)
proc get_ProxyFactory*(self: ptr IUIAutomationProxyFactoryEntry, factory: ptr ptr IUIAutomationProxyFactory): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ProxyFactory(self, factory)
proc get_ClassName*(self: ptr IUIAutomationProxyFactoryEntry, className: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ClassName(self, className)
proc get_ImageName*(self: ptr IUIAutomationProxyFactoryEntry, imageName: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ImageName(self, imageName)
proc get_AllowSubstringMatch*(self: ptr IUIAutomationProxyFactoryEntry, allowSubstringMatch: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_AllowSubstringMatch(self, allowSubstringMatch)
proc get_CanCheckBaseClass*(self: ptr IUIAutomationProxyFactoryEntry, canCheckBaseClass: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CanCheckBaseClass(self, canCheckBaseClass)
proc get_NeedsAdviseEvents*(self: ptr IUIAutomationProxyFactoryEntry, adviseEvents: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_NeedsAdviseEvents(self, adviseEvents)
proc put_ClassName*(self: ptr IUIAutomationProxyFactoryEntry, className: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ClassName(self, className)
proc put_ImageName*(self: ptr IUIAutomationProxyFactoryEntry, imageName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ImageName(self, imageName)
proc put_AllowSubstringMatch*(self: ptr IUIAutomationProxyFactoryEntry, allowSubstringMatch: BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_AllowSubstringMatch(self, allowSubstringMatch)
proc put_CanCheckBaseClass*(self: ptr IUIAutomationProxyFactoryEntry, canCheckBaseClass: BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_CanCheckBaseClass(self, canCheckBaseClass)
proc put_NeedsAdviseEvents*(self: ptr IUIAutomationProxyFactoryEntry, adviseEvents: BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_NeedsAdviseEvents(self, adviseEvents)
proc SetWinEventsForAutomationEvent*(self: ptr IUIAutomationProxyFactoryEntry, eventId: EVENTID, propertyId: PROPERTYID, winEvents: ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetWinEventsForAutomationEvent(self, eventId, propertyId, winEvents)
proc GetWinEventsForAutomationEvent*(self: ptr IUIAutomationProxyFactoryEntry, eventId: EVENTID, propertyId: PROPERTYID, winEvents: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetWinEventsForAutomationEvent(self, eventId, propertyId, winEvents)
proc get_Count*(self: ptr IUIAutomationProxyFactoryMapping, count: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_Count(self, count)
proc GetTable*(self: ptr IUIAutomationProxyFactoryMapping, table: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetTable(self, table)
proc GetEntry*(self: ptr IUIAutomationProxyFactoryMapping, index: UINT, entry: ptr ptr IUIAutomationProxyFactoryEntry): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEntry(self, index, entry)
proc SetTable*(self: ptr IUIAutomationProxyFactoryMapping, factoryList: ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetTable(self, factoryList)
proc InsertEntries*(self: ptr IUIAutomationProxyFactoryMapping, before: UINT, factoryList: ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InsertEntries(self, before, factoryList)
proc InsertEntry*(self: ptr IUIAutomationProxyFactoryMapping, before: UINT, factory: ptr IUIAutomationProxyFactoryEntry): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InsertEntry(self, before, factory)
proc RemoveEntry*(self: ptr IUIAutomationProxyFactoryMapping, index: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveEntry(self, index)
proc ClearTable*(self: ptr IUIAutomationProxyFactoryMapping): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ClearTable(self)
proc RestoreDefaultTable*(self: ptr IUIAutomationProxyFactoryMapping): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RestoreDefaultTable(self)
proc AddActiveTextPositionChangedEventHandler*(self: ptr IUIAutomationEventHandlerGroup, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationActiveTextPositionChangedEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddActiveTextPositionChangedEventHandler(self, scope, cacheRequest, handler)
proc AddAutomationEventHandler*(self: ptr IUIAutomationEventHandlerGroup, eventId: EVENTID, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddAutomationEventHandler(self, eventId, scope, cacheRequest, handler)
proc AddChangesEventHandler*(self: ptr IUIAutomationEventHandlerGroup, scope: TreeScope, changeTypes: ptr int32, changesCount: int32, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationChangesEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddChangesEventHandler(self, scope, changeTypes, changesCount, cacheRequest, handler)
proc AddNotificationEventHandler*(self: ptr IUIAutomationEventHandlerGroup, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationNotificationEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddNotificationEventHandler(self, scope, cacheRequest, handler)
proc AddPropertyChangedEventHandler*(self: ptr IUIAutomationEventHandlerGroup, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationPropertyChangedEventHandler, propertyArray: ptr PROPERTYID, propertyCount: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddPropertyChangedEventHandler(self, scope, cacheRequest, handler, propertyArray, propertyCount)
proc AddStructureChangedEventHandler*(self: ptr IUIAutomationEventHandlerGroup, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationStructureChangedEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddStructureChangedEventHandler(self, scope, cacheRequest, handler)
proc AddTextEditTextChangedEventHandler*(self: ptr IUIAutomationEventHandlerGroup, scope: TreeScope, textEditChangeType: TextEditChangeType, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationTextEditTextChangedEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddTextEditTextChangedEventHandler(self, scope, textEditChangeType, cacheRequest, handler)
proc CompareElements*(self: ptr IUIAutomation, el1: ptr IUIAutomationElement, el2: ptr IUIAutomationElement, areSame: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CompareElements(self, el1, el2, areSame)
proc CompareRuntimeIds*(self: ptr IUIAutomation, runtimeId1: ptr SAFEARRAY, runtimeId2: ptr SAFEARRAY, areSame: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CompareRuntimeIds(self, runtimeId1, runtimeId2, areSame)
proc GetRootElement*(self: ptr IUIAutomation, root: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRootElement(self, root)
proc ElementFromHandle*(self: ptr IUIAutomation, hwnd: UIA_HWND, element: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ElementFromHandle(self, hwnd, element)
proc ElementFromPoint*(self: ptr IUIAutomation, pt: POINT, element: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ElementFromPoint(self, pt, element)
proc GetFocusedElement*(self: ptr IUIAutomation, element: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFocusedElement(self, element)
proc GetRootElementBuildCache*(self: ptr IUIAutomation, cacheRequest: ptr IUIAutomationCacheRequest, root: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetRootElementBuildCache(self, cacheRequest, root)
proc ElementFromHandleBuildCache*(self: ptr IUIAutomation, hwnd: UIA_HWND, cacheRequest: ptr IUIAutomationCacheRequest, element: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ElementFromHandleBuildCache(self, hwnd, cacheRequest, element)
proc ElementFromPointBuildCache*(self: ptr IUIAutomation, pt: POINT, cacheRequest: ptr IUIAutomationCacheRequest, element: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ElementFromPointBuildCache(self, pt, cacheRequest, element)
proc GetFocusedElementBuildCache*(self: ptr IUIAutomation, cacheRequest: ptr IUIAutomationCacheRequest, element: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFocusedElementBuildCache(self, cacheRequest, element)
proc CreateTreeWalker*(self: ptr IUIAutomation, pCondition: ptr IUIAutomationCondition, walker: ptr ptr IUIAutomationTreeWalker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateTreeWalker(self, pCondition, walker)
proc get_ControlViewWalker*(self: ptr IUIAutomation, walker: ptr ptr IUIAutomationTreeWalker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ControlViewWalker(self, walker)
proc get_ContentViewWalker*(self: ptr IUIAutomation, walker: ptr ptr IUIAutomationTreeWalker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ContentViewWalker(self, walker)
proc get_RawViewWalker*(self: ptr IUIAutomation, walker: ptr ptr IUIAutomationTreeWalker): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_RawViewWalker(self, walker)
proc get_RawViewCondition*(self: ptr IUIAutomation, condition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_RawViewCondition(self, condition)
proc get_ControlViewCondition*(self: ptr IUIAutomation, condition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ControlViewCondition(self, condition)
proc get_ContentViewCondition*(self: ptr IUIAutomation, condition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ContentViewCondition(self, condition)
proc CreateCacheRequest*(self: ptr IUIAutomation, cacheRequest: ptr ptr IUIAutomationCacheRequest): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateCacheRequest(self, cacheRequest)
proc CreateTrueCondition*(self: ptr IUIAutomation, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateTrueCondition(self, newCondition)
proc CreateFalseCondition*(self: ptr IUIAutomation, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateFalseCondition(self, newCondition)
proc CreatePropertyCondition*(self: ptr IUIAutomation, propertyId: PROPERTYID, value: VARIANT, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreatePropertyCondition(self, propertyId, value, newCondition)
proc CreatePropertyConditionEx*(self: ptr IUIAutomation, propertyId: PROPERTYID, value: VARIANT, flags: PropertyConditionFlags, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreatePropertyConditionEx(self, propertyId, value, flags, newCondition)
proc CreateAndCondition*(self: ptr IUIAutomation, condition1: ptr IUIAutomationCondition, condition2: ptr IUIAutomationCondition, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateAndCondition(self, condition1, condition2, newCondition)
proc CreateAndConditionFromArray*(self: ptr IUIAutomation, conditions: ptr SAFEARRAY, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateAndConditionFromArray(self, conditions, newCondition)
proc CreateAndConditionFromNativeArray*(self: ptr IUIAutomation, conditions: ptr ptr IUIAutomationCondition, conditionCount: int32, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateAndConditionFromNativeArray(self, conditions, conditionCount, newCondition)
proc CreateOrCondition*(self: ptr IUIAutomation, condition1: ptr IUIAutomationCondition, condition2: ptr IUIAutomationCondition, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateOrCondition(self, condition1, condition2, newCondition)
proc CreateOrConditionFromArray*(self: ptr IUIAutomation, conditions: ptr SAFEARRAY, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateOrConditionFromArray(self, conditions, newCondition)
proc CreateOrConditionFromNativeArray*(self: ptr IUIAutomation, conditions: ptr ptr IUIAutomationCondition, conditionCount: int32, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateOrConditionFromNativeArray(self, conditions, conditionCount, newCondition)
proc CreateNotCondition*(self: ptr IUIAutomation, condition: ptr IUIAutomationCondition, newCondition: ptr ptr IUIAutomationCondition): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateNotCondition(self, condition, newCondition)
proc AddAutomationEventHandler*(self: ptr IUIAutomation, eventId: EVENTID, element: ptr IUIAutomationElement, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddAutomationEventHandler(self, eventId, element, scope, cacheRequest, handler)
proc RemoveAutomationEventHandler*(self: ptr IUIAutomation, eventId: EVENTID, element: ptr IUIAutomationElement, handler: ptr IUIAutomationEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveAutomationEventHandler(self, eventId, element, handler)
proc AddPropertyChangedEventHandlerNativeArray*(self: ptr IUIAutomation, element: ptr IUIAutomationElement, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationPropertyChangedEventHandler, propertyArray: ptr PROPERTYID, propertyCount: int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddPropertyChangedEventHandlerNativeArray(self, element, scope, cacheRequest, handler, propertyArray, propertyCount)
proc AddPropertyChangedEventHandler*(self: ptr IUIAutomation, element: ptr IUIAutomationElement, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationPropertyChangedEventHandler, propertyArray: ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddPropertyChangedEventHandler(self, element, scope, cacheRequest, handler, propertyArray)
proc RemovePropertyChangedEventHandler*(self: ptr IUIAutomation, element: ptr IUIAutomationElement, handler: ptr IUIAutomationPropertyChangedEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemovePropertyChangedEventHandler(self, element, handler)
proc AddStructureChangedEventHandler*(self: ptr IUIAutomation, element: ptr IUIAutomationElement, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationStructureChangedEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddStructureChangedEventHandler(self, element, scope, cacheRequest, handler)
proc RemoveStructureChangedEventHandler*(self: ptr IUIAutomation, element: ptr IUIAutomationElement, handler: ptr IUIAutomationStructureChangedEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveStructureChangedEventHandler(self, element, handler)
proc AddFocusChangedEventHandler*(self: ptr IUIAutomation, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationFocusChangedEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddFocusChangedEventHandler(self, cacheRequest, handler)
proc RemoveFocusChangedEventHandler*(self: ptr IUIAutomation, handler: ptr IUIAutomationFocusChangedEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveFocusChangedEventHandler(self, handler)
proc RemoveAllEventHandlers*(self: ptr IUIAutomation): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveAllEventHandlers(self)
proc IntNativeArrayToSafeArray*(self: ptr IUIAutomation, array: ptr int32, arrayCount: int32, safeArray: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IntNativeArrayToSafeArray(self, array, arrayCount, safeArray)
proc IntSafeArrayToNativeArray*(self: ptr IUIAutomation, intArray: ptr SAFEARRAY, array: ptr ptr int32, arrayCount: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IntSafeArrayToNativeArray(self, intArray, array, arrayCount)
proc RectToVariant*(self: ptr IUIAutomation, rc: RECT, `var`: ptr VARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RectToVariant(self, rc, `var`)
proc VariantToRect*(self: ptr IUIAutomation, `var`: VARIANT, rc: ptr RECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.VariantToRect(self, `var`, rc)
proc SafeArrayToRectNativeArray*(self: ptr IUIAutomation, rects: ptr SAFEARRAY, rectArray: ptr ptr RECT, rectArrayCount: ptr int32): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SafeArrayToRectNativeArray(self, rects, rectArray, rectArrayCount)
proc CreateProxyFactoryEntry*(self: ptr IUIAutomation, factory: ptr IUIAutomationProxyFactory, factoryEntry: ptr ptr IUIAutomationProxyFactoryEntry): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateProxyFactoryEntry(self, factory, factoryEntry)
proc get_ProxyFactoryMapping*(self: ptr IUIAutomation, factoryMapping: ptr ptr IUIAutomationProxyFactoryMapping): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ProxyFactoryMapping(self, factoryMapping)
proc GetPropertyProgrammaticName*(self: ptr IUIAutomation, property: PROPERTYID, name: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPropertyProgrammaticName(self, property, name)
proc GetPatternProgrammaticName*(self: ptr IUIAutomation, pattern: PATTERNID, name: ptr BSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPatternProgrammaticName(self, pattern, name)
proc PollForPotentialSupportedPatterns*(self: ptr IUIAutomation, pElement: ptr IUIAutomationElement, patternIds: ptr ptr SAFEARRAY, patternNames: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PollForPotentialSupportedPatterns(self, pElement, patternIds, patternNames)
proc PollForPotentialSupportedProperties*(self: ptr IUIAutomation, pElement: ptr IUIAutomationElement, propertyIds: ptr ptr SAFEARRAY, propertyNames: ptr ptr SAFEARRAY): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.PollForPotentialSupportedProperties(self, pElement, propertyIds, propertyNames)
proc CheckNotSupported*(self: ptr IUIAutomation, value: VARIANT, isNotSupported: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CheckNotSupported(self, value, isNotSupported)
proc get_ReservedNotSupportedValue*(self: ptr IUIAutomation, notSupportedValue: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ReservedNotSupportedValue(self, notSupportedValue)
proc get_ReservedMixedAttributeValue*(self: ptr IUIAutomation, mixedAttributeValue: ptr ptr IUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ReservedMixedAttributeValue(self, mixedAttributeValue)
proc ElementFromIAccessible*(self: ptr IUIAutomation, accessible: ptr IAccessible, childId: int32, element: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ElementFromIAccessible(self, accessible, childId, element)
proc ElementFromIAccessibleBuildCache*(self: ptr IUIAutomation, accessible: ptr IAccessible, childId: int32, cacheRequest: ptr IUIAutomationCacheRequest, element: ptr ptr IUIAutomationElement): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ElementFromIAccessibleBuildCache(self, accessible, childId, cacheRequest, element)
proc get_AutoSetFocus*(self: ptr IUIAutomation2, autoSetFocus: ptr BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_AutoSetFocus(self, autoSetFocus)
proc put_AutoSetFocus*(self: ptr IUIAutomation2, autoSetFocus: BOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_AutoSetFocus(self, autoSetFocus)
proc get_ConnectionTimeout*(self: ptr IUIAutomation2, timeout: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ConnectionTimeout(self, timeout)
proc put_ConnectionTimeout*(self: ptr IUIAutomation2, timeout: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ConnectionTimeout(self, timeout)
proc get_TransactionTimeout*(self: ptr IUIAutomation2, timeout: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_TransactionTimeout(self, timeout)
proc put_TransactionTimeout*(self: ptr IUIAutomation2, timeout: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_TransactionTimeout(self, timeout)
proc AddTextEditTextChangedEventHandler*(self: ptr IUIAutomation3, element: ptr IUIAutomationElement, scope: TreeScope, textEditChangeType: TextEditChangeType, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationTextEditTextChangedEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddTextEditTextChangedEventHandler(self, element, scope, textEditChangeType, cacheRequest, handler)
proc RemoveTextEditTextChangedEventHandler*(self: ptr IUIAutomation3, element: ptr IUIAutomationElement, handler: ptr IUIAutomationTextEditTextChangedEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveTextEditTextChangedEventHandler(self, element, handler)
proc AddChangesEventHandler*(self: ptr IUIAutomation4, element: ptr IUIAutomationElement, scope: TreeScope, changeTypes: ptr int32, changesCount: int32, pCacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationChangesEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddChangesEventHandler(self, element, scope, changeTypes, changesCount, pCacheRequest, handler)
proc RemoveChangesEventHandler*(self: ptr IUIAutomation4, element: ptr IUIAutomationElement, handler: ptr IUIAutomationChangesEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveChangesEventHandler(self, element, handler)
proc AddNotificationEventHandler*(self: ptr IUIAutomation5, element: ptr IUIAutomationElement, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationNotificationEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddNotificationEventHandler(self, element, scope, cacheRequest, handler)
proc RemoveNotificationEventHandler*(self: ptr IUIAutomation5, element: ptr IUIAutomationElement, handler: ptr IUIAutomationNotificationEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveNotificationEventHandler(self, element, handler)
proc CreateEventHandlerGroup*(self: ptr IUIAutomation6, handlerGroup: ptr ptr IUIAutomationEventHandlerGroup): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateEventHandlerGroup(self, handlerGroup)
proc AddEventHandlerGroup*(self: ptr IUIAutomation6, element: ptr IUIAutomationElement, handlerGroup: ptr IUIAutomationEventHandlerGroup): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddEventHandlerGroup(self, element, handlerGroup)
proc RemoveEventHandlerGroup*(self: ptr IUIAutomation6, element: ptr IUIAutomationElement, handlerGroup: ptr IUIAutomationEventHandlerGroup): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveEventHandlerGroup(self, element, handlerGroup)
proc get_ConnectionRecoveryBehavior*(self: ptr IUIAutomation6, connectionRecoveryBehaviorOptions: ptr ConnectionRecoveryBehaviorOptions): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_ConnectionRecoveryBehavior(self, connectionRecoveryBehaviorOptions)
proc put_ConnectionRecoveryBehavior*(self: ptr IUIAutomation6, connectionRecoveryBehaviorOptions: ConnectionRecoveryBehaviorOptions): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_ConnectionRecoveryBehavior(self, connectionRecoveryBehaviorOptions)
proc get_CoalesceEvents*(self: ptr IUIAutomation6, coalesceEventsOptions: ptr CoalesceEventsOptions): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.get_CoalesceEvents(self, coalesceEventsOptions)
proc put_CoalesceEvents*(self: ptr IUIAutomation6, coalesceEventsOptions: CoalesceEventsOptions): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.put_CoalesceEvents(self, coalesceEventsOptions)
proc AddActiveTextPositionChangedEventHandler*(self: ptr IUIAutomation6, element: ptr IUIAutomationElement, scope: TreeScope, cacheRequest: ptr IUIAutomationCacheRequest, handler: ptr IUIAutomationActiveTextPositionChangedEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.AddActiveTextPositionChangedEventHandler(self, element, scope, cacheRequest, handler)
proc RemoveActiveTextPositionChangedEventHandler*(self: ptr IUIAutomation6, element: ptr IUIAutomationElement, handler: ptr IUIAutomationActiveTextPositionChangedEventHandler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveActiveTextPositionChangedEventHandler(self, element, handler)
converter winimConverterIRawElementProviderSimpleToIUnknown*(x: ptr IRawElementProviderSimple): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAccessibleExToIUnknown*(x: ptr IAccessibleEx): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRawElementProviderSimple2ToIRawElementProviderSimple*(x: ptr IRawElementProviderSimple2): ptr IRawElementProviderSimple = cast[ptr IRawElementProviderSimple](x)
converter winimConverterIRawElementProviderSimple2ToIUnknown*(x: ptr IRawElementProviderSimple2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRawElementProviderSimple3ToIRawElementProviderSimple2*(x: ptr IRawElementProviderSimple3): ptr IRawElementProviderSimple2 = cast[ptr IRawElementProviderSimple2](x)
converter winimConverterIRawElementProviderSimple3ToIRawElementProviderSimple*(x: ptr IRawElementProviderSimple3): ptr IRawElementProviderSimple = cast[ptr IRawElementProviderSimple](x)
converter winimConverterIRawElementProviderSimple3ToIUnknown*(x: ptr IRawElementProviderSimple3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRawElementProviderFragmentRootToIUnknown*(x: ptr IRawElementProviderFragmentRoot): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRawElementProviderFragmentToIUnknown*(x: ptr IRawElementProviderFragment): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRawElementProviderAdviseEventsToIUnknown*(x: ptr IRawElementProviderAdviseEvents): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRawElementProviderHwndOverrideToIUnknown*(x: ptr IRawElementProviderHwndOverride): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIProxyProviderWinEventSinkToIUnknown*(x: ptr IProxyProviderWinEventSink): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIProxyProviderWinEventHandlerToIUnknown*(x: ptr IProxyProviderWinEventHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRawElementProviderWindowlessSiteToIUnknown*(x: ptr IRawElementProviderWindowlessSite): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAccessibleHostingElementProvidersToIUnknown*(x: ptr IAccessibleHostingElementProviders): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRawElementProviderHostingAccessiblesToIUnknown*(x: ptr IRawElementProviderHostingAccessibles): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDockProviderToIUnknown*(x: ptr IDockProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIExpandCollapseProviderToIUnknown*(x: ptr IExpandCollapseProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIGridProviderToIUnknown*(x: ptr IGridProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIGridItemProviderToIUnknown*(x: ptr IGridItemProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIInvokeProviderToIUnknown*(x: ptr IInvokeProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIMultipleViewProviderToIUnknown*(x: ptr IMultipleViewProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRangeValueProviderToIUnknown*(x: ptr IRangeValueProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIScrollItemProviderToIUnknown*(x: ptr IScrollItemProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISelectionProviderToIUnknown*(x: ptr ISelectionProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISelectionProvider2ToISelectionProvider*(x: ptr ISelectionProvider2): ptr ISelectionProvider = cast[ptr ISelectionProvider](x)
converter winimConverterISelectionProvider2ToIUnknown*(x: ptr ISelectionProvider2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIScrollProviderToIUnknown*(x: ptr IScrollProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISelectionItemProviderToIUnknown*(x: ptr ISelectionItemProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISynchronizedInputProviderToIUnknown*(x: ptr ISynchronizedInputProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITableProviderToIUnknown*(x: ptr ITableProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITableItemProviderToIUnknown*(x: ptr ITableItemProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIToggleProviderToIUnknown*(x: ptr IToggleProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITransformProviderToIUnknown*(x: ptr ITransformProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIValueProviderToIUnknown*(x: ptr IValueProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWindowProviderToIUnknown*(x: ptr IWindowProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterILegacyIAccessibleProviderToIUnknown*(x: ptr ILegacyIAccessibleProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIItemContainerProviderToIUnknown*(x: ptr IItemContainerProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIVirtualizedItemProviderToIUnknown*(x: ptr IVirtualizedItemProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIObjectModelProviderToIUnknown*(x: ptr IObjectModelProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIAnnotationProviderToIUnknown*(x: ptr IAnnotationProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIStylesProviderToIUnknown*(x: ptr IStylesProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISpreadsheetProviderToIUnknown*(x: ptr ISpreadsheetProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterISpreadsheetItemProviderToIUnknown*(x: ptr ISpreadsheetItemProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITransformProvider2ToITransformProvider*(x: ptr ITransformProvider2): ptr ITransformProvider = cast[ptr ITransformProvider](x)
converter winimConverterITransformProvider2ToIUnknown*(x: ptr ITransformProvider2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDragProviderToIUnknown*(x: ptr IDragProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIDropTargetProviderToIUnknown*(x: ptr IDropTargetProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITextRangeProviderToIUnknown*(x: ptr ITextRangeProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITextProviderToIUnknown*(x: ptr ITextProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITextProvider2ToITextProvider*(x: ptr ITextProvider2): ptr ITextProvider = cast[ptr ITextProvider](x)
converter winimConverterITextProvider2ToIUnknown*(x: ptr ITextProvider2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITextEditProviderToITextProvider*(x: ptr ITextEditProvider): ptr ITextProvider = cast[ptr ITextProvider](x)
converter winimConverterITextEditProviderToIUnknown*(x: ptr ITextEditProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITextRangeProvider2ToITextRangeProvider*(x: ptr ITextRangeProvider2): ptr ITextRangeProvider = cast[ptr ITextRangeProvider](x)
converter winimConverterITextRangeProvider2ToIUnknown*(x: ptr ITextRangeProvider2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterITextChildProviderToIUnknown*(x: ptr ITextChildProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterICustomNavigationProviderToIUnknown*(x: ptr ICustomNavigationProvider): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationPatternInstanceToIUnknown*(x: ptr IUIAutomationPatternInstance): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationPatternHandlerToIUnknown*(x: ptr IUIAutomationPatternHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationRegistrarToIUnknown*(x: ptr IUIAutomationRegistrar): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationElementToIUnknown*(x: ptr IUIAutomationElement): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationElementArrayToIUnknown*(x: ptr IUIAutomationElementArray): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationConditionToIUnknown*(x: ptr IUIAutomationCondition): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationBoolConditionToIUIAutomationCondition*(x: ptr IUIAutomationBoolCondition): ptr IUIAutomationCondition = cast[ptr IUIAutomationCondition](x)
converter winimConverterIUIAutomationBoolConditionToIUnknown*(x: ptr IUIAutomationBoolCondition): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationPropertyConditionToIUIAutomationCondition*(x: ptr IUIAutomationPropertyCondition): ptr IUIAutomationCondition = cast[ptr IUIAutomationCondition](x)
converter winimConverterIUIAutomationPropertyConditionToIUnknown*(x: ptr IUIAutomationPropertyCondition): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationAndConditionToIUIAutomationCondition*(x: ptr IUIAutomationAndCondition): ptr IUIAutomationCondition = cast[ptr IUIAutomationCondition](x)
converter winimConverterIUIAutomationAndConditionToIUnknown*(x: ptr IUIAutomationAndCondition): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationOrConditionToIUIAutomationCondition*(x: ptr IUIAutomationOrCondition): ptr IUIAutomationCondition = cast[ptr IUIAutomationCondition](x)
converter winimConverterIUIAutomationOrConditionToIUnknown*(x: ptr IUIAutomationOrCondition): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationNotConditionToIUIAutomationCondition*(x: ptr IUIAutomationNotCondition): ptr IUIAutomationCondition = cast[ptr IUIAutomationCondition](x)
converter winimConverterIUIAutomationNotConditionToIUnknown*(x: ptr IUIAutomationNotCondition): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationCacheRequestToIUnknown*(x: ptr IUIAutomationCacheRequest): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTreeWalkerToIUnknown*(x: ptr IUIAutomationTreeWalker): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationEventHandlerToIUnknown*(x: ptr IUIAutomationEventHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationPropertyChangedEventHandlerToIUnknown*(x: ptr IUIAutomationPropertyChangedEventHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationStructureChangedEventHandlerToIUnknown*(x: ptr IUIAutomationStructureChangedEventHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationFocusChangedEventHandlerToIUnknown*(x: ptr IUIAutomationFocusChangedEventHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTextEditTextChangedEventHandlerToIUnknown*(x: ptr IUIAutomationTextEditTextChangedEventHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationChangesEventHandlerToIUnknown*(x: ptr IUIAutomationChangesEventHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationNotificationEventHandlerToIUnknown*(x: ptr IUIAutomationNotificationEventHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationInvokePatternToIUnknown*(x: ptr IUIAutomationInvokePattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationDockPatternToIUnknown*(x: ptr IUIAutomationDockPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationExpandCollapsePatternToIUnknown*(x: ptr IUIAutomationExpandCollapsePattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationGridPatternToIUnknown*(x: ptr IUIAutomationGridPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationGridItemPatternToIUnknown*(x: ptr IUIAutomationGridItemPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationMultipleViewPatternToIUnknown*(x: ptr IUIAutomationMultipleViewPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationObjectModelPatternToIUnknown*(x: ptr IUIAutomationObjectModelPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationRangeValuePatternToIUnknown*(x: ptr IUIAutomationRangeValuePattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationScrollPatternToIUnknown*(x: ptr IUIAutomationScrollPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationScrollItemPatternToIUnknown*(x: ptr IUIAutomationScrollItemPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationSelectionPatternToIUnknown*(x: ptr IUIAutomationSelectionPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationSelectionPattern2ToIUIAutomationSelectionPattern*(x: ptr IUIAutomationSelectionPattern2): ptr IUIAutomationSelectionPattern = cast[ptr IUIAutomationSelectionPattern](x)
converter winimConverterIUIAutomationSelectionPattern2ToIUnknown*(x: ptr IUIAutomationSelectionPattern2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationSelectionItemPatternToIUnknown*(x: ptr IUIAutomationSelectionItemPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationSynchronizedInputPatternToIUnknown*(x: ptr IUIAutomationSynchronizedInputPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTablePatternToIUnknown*(x: ptr IUIAutomationTablePattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTableItemPatternToIUnknown*(x: ptr IUIAutomationTableItemPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTogglePatternToIUnknown*(x: ptr IUIAutomationTogglePattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTransformPatternToIUnknown*(x: ptr IUIAutomationTransformPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationValuePatternToIUnknown*(x: ptr IUIAutomationValuePattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationWindowPatternToIUnknown*(x: ptr IUIAutomationWindowPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTextRangeToIUnknown*(x: ptr IUIAutomationTextRange): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTextRange2ToIUIAutomationTextRange*(x: ptr IUIAutomationTextRange2): ptr IUIAutomationTextRange = cast[ptr IUIAutomationTextRange](x)
converter winimConverterIUIAutomationTextRange2ToIUnknown*(x: ptr IUIAutomationTextRange2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTextRange3ToIUIAutomationTextRange2*(x: ptr IUIAutomationTextRange3): ptr IUIAutomationTextRange2 = cast[ptr IUIAutomationTextRange2](x)
converter winimConverterIUIAutomationTextRange3ToIUIAutomationTextRange*(x: ptr IUIAutomationTextRange3): ptr IUIAutomationTextRange = cast[ptr IUIAutomationTextRange](x)
converter winimConverterIUIAutomationTextRange3ToIUnknown*(x: ptr IUIAutomationTextRange3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTextRangeArrayToIUnknown*(x: ptr IUIAutomationTextRangeArray): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTextPatternToIUnknown*(x: ptr IUIAutomationTextPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTextPattern2ToIUIAutomationTextPattern*(x: ptr IUIAutomationTextPattern2): ptr IUIAutomationTextPattern = cast[ptr IUIAutomationTextPattern](x)
converter winimConverterIUIAutomationTextPattern2ToIUnknown*(x: ptr IUIAutomationTextPattern2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTextEditPatternToIUIAutomationTextPattern*(x: ptr IUIAutomationTextEditPattern): ptr IUIAutomationTextPattern = cast[ptr IUIAutomationTextPattern](x)
converter winimConverterIUIAutomationTextEditPatternToIUnknown*(x: ptr IUIAutomationTextEditPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationCustomNavigationPatternToIUnknown*(x: ptr IUIAutomationCustomNavigationPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationActiveTextPositionChangedEventHandlerToIUnknown*(x: ptr IUIAutomationActiveTextPositionChangedEventHandler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationLegacyIAccessiblePatternToIUnknown*(x: ptr IUIAutomationLegacyIAccessiblePattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationItemContainerPatternToIUnknown*(x: ptr IUIAutomationItemContainerPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationVirtualizedItemPatternToIUnknown*(x: ptr IUIAutomationVirtualizedItemPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationAnnotationPatternToIUnknown*(x: ptr IUIAutomationAnnotationPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationStylesPatternToIUnknown*(x: ptr IUIAutomationStylesPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationSpreadsheetPatternToIUnknown*(x: ptr IUIAutomationSpreadsheetPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationSpreadsheetItemPatternToIUnknown*(x: ptr IUIAutomationSpreadsheetItemPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTransformPattern2ToIUIAutomationTransformPattern*(x: ptr IUIAutomationTransformPattern2): ptr IUIAutomationTransformPattern = cast[ptr IUIAutomationTransformPattern](x)
converter winimConverterIUIAutomationTransformPattern2ToIUnknown*(x: ptr IUIAutomationTransformPattern2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationTextChildPatternToIUnknown*(x: ptr IUIAutomationTextChildPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationDragPatternToIUnknown*(x: ptr IUIAutomationDragPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationDropTargetPatternToIUnknown*(x: ptr IUIAutomationDropTargetPattern): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationElement2ToIUIAutomationElement*(x: ptr IUIAutomationElement2): ptr IUIAutomationElement = cast[ptr IUIAutomationElement](x)
converter winimConverterIUIAutomationElement2ToIUnknown*(x: ptr IUIAutomationElement2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationElement3ToIUIAutomationElement2*(x: ptr IUIAutomationElement3): ptr IUIAutomationElement2 = cast[ptr IUIAutomationElement2](x)
converter winimConverterIUIAutomationElement3ToIUIAutomationElement*(x: ptr IUIAutomationElement3): ptr IUIAutomationElement = cast[ptr IUIAutomationElement](x)
converter winimConverterIUIAutomationElement3ToIUnknown*(x: ptr IUIAutomationElement3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationElement4ToIUIAutomationElement3*(x: ptr IUIAutomationElement4): ptr IUIAutomationElement3 = cast[ptr IUIAutomationElement3](x)
converter winimConverterIUIAutomationElement4ToIUIAutomationElement2*(x: ptr IUIAutomationElement4): ptr IUIAutomationElement2 = cast[ptr IUIAutomationElement2](x)
converter winimConverterIUIAutomationElement4ToIUIAutomationElement*(x: ptr IUIAutomationElement4): ptr IUIAutomationElement = cast[ptr IUIAutomationElement](x)
converter winimConverterIUIAutomationElement4ToIUnknown*(x: ptr IUIAutomationElement4): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationElement5ToIUIAutomationElement4*(x: ptr IUIAutomationElement5): ptr IUIAutomationElement4 = cast[ptr IUIAutomationElement4](x)
converter winimConverterIUIAutomationElement5ToIUIAutomationElement3*(x: ptr IUIAutomationElement5): ptr IUIAutomationElement3 = cast[ptr IUIAutomationElement3](x)
converter winimConverterIUIAutomationElement5ToIUIAutomationElement2*(x: ptr IUIAutomationElement5): ptr IUIAutomationElement2 = cast[ptr IUIAutomationElement2](x)
converter winimConverterIUIAutomationElement5ToIUIAutomationElement*(x: ptr IUIAutomationElement5): ptr IUIAutomationElement = cast[ptr IUIAutomationElement](x)
converter winimConverterIUIAutomationElement5ToIUnknown*(x: ptr IUIAutomationElement5): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationElement6ToIUIAutomationElement5*(x: ptr IUIAutomationElement6): ptr IUIAutomationElement5 = cast[ptr IUIAutomationElement5](x)
converter winimConverterIUIAutomationElement6ToIUIAutomationElement4*(x: ptr IUIAutomationElement6): ptr IUIAutomationElement4 = cast[ptr IUIAutomationElement4](x)
converter winimConverterIUIAutomationElement6ToIUIAutomationElement3*(x: ptr IUIAutomationElement6): ptr IUIAutomationElement3 = cast[ptr IUIAutomationElement3](x)
converter winimConverterIUIAutomationElement6ToIUIAutomationElement2*(x: ptr IUIAutomationElement6): ptr IUIAutomationElement2 = cast[ptr IUIAutomationElement2](x)
converter winimConverterIUIAutomationElement6ToIUIAutomationElement*(x: ptr IUIAutomationElement6): ptr IUIAutomationElement = cast[ptr IUIAutomationElement](x)
converter winimConverterIUIAutomationElement6ToIUnknown*(x: ptr IUIAutomationElement6): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationElement7ToIUIAutomationElement6*(x: ptr IUIAutomationElement7): ptr IUIAutomationElement6 = cast[ptr IUIAutomationElement6](x)
converter winimConverterIUIAutomationElement7ToIUIAutomationElement5*(x: ptr IUIAutomationElement7): ptr IUIAutomationElement5 = cast[ptr IUIAutomationElement5](x)
converter winimConverterIUIAutomationElement7ToIUIAutomationElement4*(x: ptr IUIAutomationElement7): ptr IUIAutomationElement4 = cast[ptr IUIAutomationElement4](x)
converter winimConverterIUIAutomationElement7ToIUIAutomationElement3*(x: ptr IUIAutomationElement7): ptr IUIAutomationElement3 = cast[ptr IUIAutomationElement3](x)
converter winimConverterIUIAutomationElement7ToIUIAutomationElement2*(x: ptr IUIAutomationElement7): ptr IUIAutomationElement2 = cast[ptr IUIAutomationElement2](x)
converter winimConverterIUIAutomationElement7ToIUIAutomationElement*(x: ptr IUIAutomationElement7): ptr IUIAutomationElement = cast[ptr IUIAutomationElement](x)
converter winimConverterIUIAutomationElement7ToIUnknown*(x: ptr IUIAutomationElement7): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationElement8ToIUIAutomationElement7*(x: ptr IUIAutomationElement8): ptr IUIAutomationElement7 = cast[ptr IUIAutomationElement7](x)
converter winimConverterIUIAutomationElement8ToIUIAutomationElement6*(x: ptr IUIAutomationElement8): ptr IUIAutomationElement6 = cast[ptr IUIAutomationElement6](x)
converter winimConverterIUIAutomationElement8ToIUIAutomationElement5*(x: ptr IUIAutomationElement8): ptr IUIAutomationElement5 = cast[ptr IUIAutomationElement5](x)
converter winimConverterIUIAutomationElement8ToIUIAutomationElement4*(x: ptr IUIAutomationElement8): ptr IUIAutomationElement4 = cast[ptr IUIAutomationElement4](x)
converter winimConverterIUIAutomationElement8ToIUIAutomationElement3*(x: ptr IUIAutomationElement8): ptr IUIAutomationElement3 = cast[ptr IUIAutomationElement3](x)
converter winimConverterIUIAutomationElement8ToIUIAutomationElement2*(x: ptr IUIAutomationElement8): ptr IUIAutomationElement2 = cast[ptr IUIAutomationElement2](x)
converter winimConverterIUIAutomationElement8ToIUIAutomationElement*(x: ptr IUIAutomationElement8): ptr IUIAutomationElement = cast[ptr IUIAutomationElement](x)
converter winimConverterIUIAutomationElement8ToIUnknown*(x: ptr IUIAutomationElement8): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationElement9ToIUIAutomationElement8*(x: ptr IUIAutomationElement9): ptr IUIAutomationElement8 = cast[ptr IUIAutomationElement8](x)
converter winimConverterIUIAutomationElement9ToIUIAutomationElement7*(x: ptr IUIAutomationElement9): ptr IUIAutomationElement7 = cast[ptr IUIAutomationElement7](x)
converter winimConverterIUIAutomationElement9ToIUIAutomationElement6*(x: ptr IUIAutomationElement9): ptr IUIAutomationElement6 = cast[ptr IUIAutomationElement6](x)
converter winimConverterIUIAutomationElement9ToIUIAutomationElement5*(x: ptr IUIAutomationElement9): ptr IUIAutomationElement5 = cast[ptr IUIAutomationElement5](x)
converter winimConverterIUIAutomationElement9ToIUIAutomationElement4*(x: ptr IUIAutomationElement9): ptr IUIAutomationElement4 = cast[ptr IUIAutomationElement4](x)
converter winimConverterIUIAutomationElement9ToIUIAutomationElement3*(x: ptr IUIAutomationElement9): ptr IUIAutomationElement3 = cast[ptr IUIAutomationElement3](x)
converter winimConverterIUIAutomationElement9ToIUIAutomationElement2*(x: ptr IUIAutomationElement9): ptr IUIAutomationElement2 = cast[ptr IUIAutomationElement2](x)
converter winimConverterIUIAutomationElement9ToIUIAutomationElement*(x: ptr IUIAutomationElement9): ptr IUIAutomationElement = cast[ptr IUIAutomationElement](x)
converter winimConverterIUIAutomationElement9ToIUnknown*(x: ptr IUIAutomationElement9): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationProxyFactoryToIUnknown*(x: ptr IUIAutomationProxyFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationProxyFactoryEntryToIUnknown*(x: ptr IUIAutomationProxyFactoryEntry): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationProxyFactoryMappingToIUnknown*(x: ptr IUIAutomationProxyFactoryMapping): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationEventHandlerGroupToIUnknown*(x: ptr IUIAutomationEventHandlerGroup): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomationToIUnknown*(x: ptr IUIAutomation): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomation2ToIUIAutomation*(x: ptr IUIAutomation2): ptr IUIAutomation = cast[ptr IUIAutomation](x)
converter winimConverterIUIAutomation2ToIUnknown*(x: ptr IUIAutomation2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomation3ToIUIAutomation2*(x: ptr IUIAutomation3): ptr IUIAutomation2 = cast[ptr IUIAutomation2](x)
converter winimConverterIUIAutomation3ToIUIAutomation*(x: ptr IUIAutomation3): ptr IUIAutomation = cast[ptr IUIAutomation](x)
converter winimConverterIUIAutomation3ToIUnknown*(x: ptr IUIAutomation3): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomation4ToIUIAutomation3*(x: ptr IUIAutomation4): ptr IUIAutomation3 = cast[ptr IUIAutomation3](x)
converter winimConverterIUIAutomation4ToIUIAutomation2*(x: ptr IUIAutomation4): ptr IUIAutomation2 = cast[ptr IUIAutomation2](x)
converter winimConverterIUIAutomation4ToIUIAutomation*(x: ptr IUIAutomation4): ptr IUIAutomation = cast[ptr IUIAutomation](x)
converter winimConverterIUIAutomation4ToIUnknown*(x: ptr IUIAutomation4): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomation5ToIUIAutomation4*(x: ptr IUIAutomation5): ptr IUIAutomation4 = cast[ptr IUIAutomation4](x)
converter winimConverterIUIAutomation5ToIUIAutomation3*(x: ptr IUIAutomation5): ptr IUIAutomation3 = cast[ptr IUIAutomation3](x)
converter winimConverterIUIAutomation5ToIUIAutomation2*(x: ptr IUIAutomation5): ptr IUIAutomation2 = cast[ptr IUIAutomation2](x)
converter winimConverterIUIAutomation5ToIUIAutomation*(x: ptr IUIAutomation5): ptr IUIAutomation = cast[ptr IUIAutomation](x)
converter winimConverterIUIAutomation5ToIUnknown*(x: ptr IUIAutomation5): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIUIAutomation6ToIUIAutomation5*(x: ptr IUIAutomation6): ptr IUIAutomation5 = cast[ptr IUIAutomation5](x)
converter winimConverterIUIAutomation6ToIUIAutomation4*(x: ptr IUIAutomation6): ptr IUIAutomation4 = cast[ptr IUIAutomation4](x)
converter winimConverterIUIAutomation6ToIUIAutomation3*(x: ptr IUIAutomation6): ptr IUIAutomation3 = cast[ptr IUIAutomation3](x)
converter winimConverterIUIAutomation6ToIUIAutomation2*(x: ptr IUIAutomation6): ptr IUIAutomation2 = cast[ptr IUIAutomation2](x)
converter winimConverterIUIAutomation6ToIUIAutomation*(x: ptr IUIAutomation6): ptr IUIAutomation = cast[ptr IUIAutomation](x)
converter winimConverterIUIAutomation6ToIUnknown*(x: ptr IUIAutomation6): ptr IUnknown = cast[ptr IUnknown](x)
