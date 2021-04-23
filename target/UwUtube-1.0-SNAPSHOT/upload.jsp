<link rel="stylesheet" href="css/upload.css">
<body>
    <form method="post" class="upload" action="/UploadController" enctype="multipart/form-data">
        <div class="upload-files" id="upload-files">
            <header>
                <p>
                    <i class="fa fa-cloud-upload" aria-hidden="true"></i>
                    <span class="up">up</span>
                    <span class="load">load</span>
                </p>
            </header>
            <div class="body" id="drop">
                <i class="fa fa-file-text-o pointer-none" aria-hidden="true"></i>
                <p class="pointer-none"><b>Drag and drop</b> files here <br /> or <a href="" id="triggerFile">browse</a> to begin the upload</p>
                <input type="file" name="file"/>
            </div>
            <footer>
                <div class="divider">
                    <span><AR>FILES</AR></span>
                </div>
                <div class="list-files">
                    <!--   template   -->
                </div>
                <button class="importar">UPLOAD VIDEO</button>
            </footer>
            <p id="add-topic">add topic</p>
        </div>
        <div class="information">
            <input type="text" placeholder="name" class="name" name="name">
            <textarea name="description" placeholder="description" class="description" id="description"></textarea>
            <div id="topic_div"></div>
        </div>
    </form>
</body>
<script src="js/upload.js"></script>