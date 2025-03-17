import os
from datasets import Features, GeneratorBasedBuilder, DatasetInfo, SplitGenerator, Split, ClassLabel, Image

class ArtPeriodDataset(GeneratorBasedBuilder):
    def _info(self):
        art_periods = ["highRenaiss", "impress", "NorthernRenaiss", "postImpress", "rococo", "Ukiyo"]
        return DatasetInfo(
            description="A dataset of paintings labeled by art period.",
            features=Features({
                "image": Image(),
                "label": ClassLabel(names=art_periods),
            }),
            supervised_keys=("image", "label"),
        )

    def _split_generators(self, dl_manager):
        # Assumes the data is stored in self.config.data_dir with one folder per art period.
        data_dir = self.config.data_dir
        # Here we're just creating a single training split. Modify as needed.
        return [SplitGenerator(name=Split.TRAIN, gen_kwargs={"data_dir": data_dir})]

    def _generate_examples(self, data_dir):
        idx = 0
        # Each folder in data_dir corresponds to an art period.
        for art_period in os.listdir(data_dir):
            period_dir = os.path.join(data_dir, art_period)
            if not os.path.isdir(period_dir):
                continue  # Skip non-directory files
            for file_name in os.listdir(period_dir):
                # Only consider image files (adjust extensions if necessary)
                if file_name.lower().endswith((".png", ".jpg", ".jpeg")):
                    file_path = os.path.join(period_dir, file_name)
                    yield idx, {"image": file_path, "label": art_period}
                    idx += 1
                    


