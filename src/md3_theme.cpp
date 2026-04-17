#include "md3_theme.h"

#include <QPalette>

namespace md3 {

void applyMaterialDesign3Theme(QApplication &app)
{
    QPalette palette;
    palette.setColor(QPalette::Window, QColor(18, 20, 28));
    palette.setColor(QPalette::WindowText, QColor(238, 238, 242));
    palette.setColor(QPalette::Base, QColor(12, 14, 22));
    palette.setColor(QPalette::AlternateBase, QColor(24, 28, 38));
    palette.setColor(QPalette::ToolTipBase, QColor(255, 255, 255));
    palette.setColor(QPalette::ToolTipText, QColor(12, 14, 22));
    palette.setColor(QPalette::Text, QColor(226, 230, 245));
    palette.setColor(QPalette::Button, QColor(25, 28, 38));
    palette.setColor(QPalette::ButtonText, QColor(238, 238, 242));
    palette.setColor(QPalette::BrightText, QColor(255, 255, 255));
    palette.setColor(QPalette::Highlight, QColor(96, 110, 255));
    palette.setColor(QPalette::HighlightedText, QColor(255, 255, 255));
    palette.setColor(QPalette::Link, QColor(98, 155, 255));

    app.setPalette(palette);
    app.setStyleSheet(
        "QWidget { background: #12151f; color: #e6e8f5; font-family: Segoe UI, Arial, sans-serif; }"
        "QPushButton { background: qlineargradient(spread:pad, x1:0, y1:0, x2:1, y2:1, stop:0 #2b3260, stop:1 #3d4b8a);" 
        "color: #f4f6ff; border: 1px solid #4a5588; border-radius: 12px; padding: 10px; }"
        "QPushButton:hover { background: #4656a2; }"
        "QLineEdit, QTextEdit, QListWidget { background: #141923; border: 1px solid #2f3b62; border-radius: 12px; color: #e8ebff; padding: 10px; }"
        "QLineEdit { min-height: 40px; }"
        "QTextEdit { min-height: 360px; }"
        "QListWidget { padding: 8px; }"
        "QLabel { color: #cfd7ff; }"
        "QScrollBar:vertical { background: #10131d; width: 12px; margin: 12px 0 12px 0; }"
        "QScrollBar::handle:vertical { background: #3d4b83; border-radius: 6px; }"
        "QScrollBar::handle:vertical:hover { background: #5b6ec2; }"
    );
}

} // namespace md3
