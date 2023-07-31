#!/bash
set +x

echo "<!DOCTYPE html>
<html>
<head>
    <meta charset=\"UTF-8\">
    <title>Lotus Profiling Report - Message Execution</title>
    <style>
        body {
            color: #333;
            margin: 0;
            padding: 0;
            background-color: #F9F9F9;
        }
        h1, h2 {
            color: #003366; /* Filecoin dark blue */
        }
        pre {
            background-color: #f5f5f5;
            padding: 10px;
            border-radius: 3px;
            color: black; /* Set font color to black */
            white-space: pre-wrap;
            word-wrap: break-word;
        }
        .svg-container {
            width: 100%;
            height: 0;
            padding-bottom: 100%;
            position: relative;
            overflow: hidden;
        }
        .svg-container svg {
            position: absolute;
            width: 100%;
            height: 100%;
            left: 0;
            top: 0;
        }
        .content {
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class=\"content\">
        <h1>Lotus Profiling Report - Message Execution</h1>
        <p>This data was collected by preparing a new Lotus node by downloading a mainnet snapshot, then running Lotus with the pprof flag. The output was analyzed after the node ran for 10 minutes while syncing mainnet.</p>" > index.html

echo "<h2>Apply Message Function Profiling</h2>" >> index.html
echo "<p>This section contains the profiling data of the ApplyMessage function, depicted in the form of a list from the profiling output.</p>" >> index.html
echo "<pre>" >> index.html
cat ApplyMessage.txt >> index.html
echo "</pre>" >> index.html

echo "<h2>Apply Message Relative Percentages</h2>" >> index.html
echo "<p>This section provides the top relative percentages of the ApplyMessage function from the profiling output.</p>" >> index.html
echo "<pre>" >> index.html
cat RelativePercentages.txt >> index.html
echo "</pre>" >> index.html

echo "<h2>SVG Profile for Apply Message Function</h2>" >> index.html
echo "<p>This SVG provides a graphical representation of the profiling data for the ApplyMessage function.</p>" >> index.html
echo "<div class=\"svg-container\">" >> index.html
sed '/^<svg /s/\(width\|height\)="[^"]*"//g' profile001.svg >> index.html
echo "</div>" >> index.html

echo "<h2>Overall Profiling Snapshot of Lotus Main Loop</h2>" >> index.html
echo "<p>This SVG visualizes a profiling snapshot of the entire execution loop of the Lotus function, with a focus on the top 500 nodes for more manageable visualization.</p>" >> index.html
echo "<div class=\"svg-container\">" >> index.html
sed '/^<svg /s/\(width\|height\)="[^"]*"//g' profile002.svg >> index.html
echo "</div>" >> index.html

echo "</div>
</body>
</html>" >> index.html

